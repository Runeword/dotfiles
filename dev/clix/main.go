package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

type model struct {
	flakePath string
	inputs    []string
	metadata  map[string]interface{}
	cursor    int
	selected  map[int]struct{}
	width     int
	height    int
}

func initialModel(flakePath string) model {
	metadata, err := getFlakeMetadata(flakePath)
	if err != nil {
		fmt.Printf("Error getting flake metadata: %v\n", err)
		os.Exit(1)
	}

	inputs := getInputs(metadata)
	return model{
		flakePath: flakePath,
		inputs:    inputs,
		metadata:  metadata,
		selected:  make(map[int]struct{}),
	}
}

func (m model) Init() tea.Cmd {
	return nil
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "ctrl+c", "q":
			return m, tea.Quit
		case "up", "k":
			if m.cursor > 0 {
				m.cursor--
			}
		case "down", "j":
			if m.cursor < len(m.inputs)-1 {
				m.cursor++
			}
		case "enter", " ":
			_, ok := m.selected[m.cursor]
			if ok {
				delete(m.selected, m.cursor)
			} else {
				m.selected[m.cursor] = struct{}{}
			}
		case "u":
			return m, tea.Quit
		}
	case tea.WindowSizeMsg:
		m.width = msg.Width
		m.height = msg.Height
	}
	return m, nil
}

func (m model) View() string {
	if m.width == 0 {
		return "Initializing..."
	}

	leftWidth := m.width / 3
	rightWidth := m.width - leftWidth - 1

	leftStyle := lipgloss.NewStyle().Width(leftWidth).Border(lipgloss.NormalBorder(), false, true, false, false)
	rightStyle := lipgloss.NewStyle().Width(rightWidth).Border(lipgloss.NormalBorder(), false, false, false, true)

	var left strings.Builder
	left.WriteString("Select inputs to update:\n\n")

	for i, input := range m.inputs {
		cursor := " "
		if m.cursor == i {
			cursor = ">"
		}

		checked := " "
		if _, ok := m.selected[i]; ok {
			checked = "x"
		}

		left.WriteString(fmt.Sprintf("%s [%s] %s\n", cursor, checked, input))
	}

	left.WriteString("\nPress u to update selected inputs, q to quit")

	right := getPreview(m.metadata, m.inputs[m.cursor])

	return lipgloss.JoinHorizontal(
		lipgloss.Left,
		leftStyle.Render(left.String()),
		rightStyle.Render(right),
	)
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run main.go <flake_path>")
		os.Exit(1)
	}

	flakePath := os.Args[1]
	p := tea.NewProgram(initialModel(flakePath), tea.WithAltScreen())
	m, err := p.Run()
	if err != nil {
		fmt.Printf("Error running program: %v\n", err)
		os.Exit(1)
	}

	finalModel := m.(model)
	updateSelectedInputs(finalModel)
}

func getFlakeMetadata(flakePath string) (map[string]interface{}, error) {
	cmd := exec.Command("nix", "flake", "metadata", flakePath, "--json")
	output, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	var metadata map[string]interface{}
	err = json.Unmarshal(output, &metadata)
	if err != nil {
		return nil, err
	}

	return metadata, nil
}

func getInputs(metadata map[string]interface{}) []string {
	locks, ok := metadata["locks"].(map[string]interface{})
	if !ok {
		return nil
	}
	nodes, ok := locks["nodes"].(map[string]interface{})
	if !ok {
		return nil
	}
	root, ok := nodes["root"].(map[string]interface{})
	if !ok {
		return nil
	}
	inputs, ok := root["inputs"].(map[string]interface{})
	if !ok {
		return nil
	}

	var result []string
	for input := range inputs {
		result = append(result, input)
	}
	return result
}

func getPreview(metadata map[string]interface{}, input string) string {
	locks, ok := metadata["locks"].(map[string]interface{})
	if !ok {
		return "No preview available"
	}
	nodes, ok := locks["nodes"].(map[string]interface{})
	if !ok {
		return "No preview available"
	}
	inputData, ok := nodes[input].(map[string]interface{})
	if !ok {
		return "No preview available"
	}

	jsonData, err := json.MarshalIndent(inputData, "", "  ")
	if err != nil {
		return "Error generating preview"
	}

	return string(jsonData)
}

func updateSelectedInputs(m model) {
	for i := range m.selected {
		input := m.inputs[i]
		cmd := exec.Command("nix", "flake", "lock", "--update-input", input, m.flakePath)
		output, err := cmd.CombinedOutput()
		if err != nil {
			fmt.Printf("Error updating input %s: %v\n", input, err)
			fmt.Println(string(output))
		} else {
			fmt.Printf("Updated input: %s\n", input)
		}
	}
}
