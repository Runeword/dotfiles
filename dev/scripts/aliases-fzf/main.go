package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"unicode"
)

type Alias struct {
	Command     string
	Description string
	Category    string
	Execute     bool
}

func parseFlags() string {
	// Get filePath
	var filePath string
	flag.StringVar(&filePath, "f", "", "Commands file path")
	flag.Parse()

	if filePath == "" {
		fmt.Fprintln(os.Stderr, "Error: commands file path is required")
		os.Exit(1)
	}

	return filePath
}

func readFile(filepath string) []string {
	// Open file at given path
	file, err := os.Open(filepath)
	// Exit if error while opening file
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error opening file: %v\n", err)
		os.Exit(1)
	}
	// Close the file when the function returns
	defer file.Close()

	var commands []string
	// Read the file line by line with a scanner
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		// Skip empty lines and comments
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}
		// Insert the line into the commands slice
		commands = append(commands, line)
	}

	// Exit if error while reading file
	if err := scanner.Err(); err != nil {
		fmt.Fprintf(os.Stderr, "Error reading file: %v\n", err)
		os.Exit(1)
	}

	return commands
}

func createFzfCommand() *exec.Cmd {
	return exec.Command("fzf",
		"--with-nth=1,2,3",
		"--print-query",
		"--query=^",
		"--exact",
		"--exit-0",
		"--nth=1",
		"--no-info",
		"--no-separator",
		"--delimiter=\t",
		"--cycle",
		"--no-preview",
		"--reverse",
		"--no-sort",
		"--prompt=  ",
		"--bind=one:accept,zero:accept,tab:accept",
		"--height=70%",
	)
}

func runFzf(commands []string) (string, error) {
	fzf := createFzfCommand()

	// Pipe any error messages from the fzf command directly to the terminal,
	// so users can see any error messages or warnings that fzf might output
	fzf.Stderr = os.Stderr

	// 1. Write commands to fzf standard input

	// Create a pipe to fzf standard input
	fzfStdin, err := fzf.StdinPipe()
	if err != nil {
		return "", fmt.Errorf("error creating stdin pipe: %v", err)
	}

	go func() {
		// Ensures the fzf stdin pipe is closed after writing commands
		defer fzfStdin.Close()
		// Write each command to fzf standard input
		for _, command := range commands {
			fmt.Fprintln(fzfStdin, command)
		}
	}()

	// 2. Get fzf output
	output, err := fzf.Output()

	// 3. Handle fzf errors
	if exitErr, ok := err.(*exec.ExitError); ok {
		// If user pressed Ctrl+C
		if exitErr.ExitCode() == 130 {
			os.Exit(0)
		}
		// If there was no fzf matches
		if exitErr.ExitCode() == 1 {
			return string(output), nil
		}
		// If there was an error running fzf
		return "", fmt.Errorf("error running fzf: %v", err)
	}

	// 3. Return fzf output
	return string(output), nil
}

// Remove from the fzf query all characters that are not letters (fzf search pattern included)
func formatFzfQuery(fzfQuery string) string {
	return strings.Map(func(char rune) rune {
		if unicode.IsLetter(char) {
			return char
		}
		return -1
	}, fzfQuery)
}

func formatFzfOutput(lines []string) {
	fzfSelection := lines[1]
	fzfQuery := lines[0]

	// If no fzf selection
	if fzfSelection == "" {
		// Format and print the fzf query
		fmt.Println(formatFzfQuery(fzfQuery))
		return
	}

	// Extract fields from fzf selection
	fields := strings.Split(fzfSelection, "\t")

	// Return if no command field
	if len(fields) < 2 {
		return
	}

	// Remove leading and trailing spaces from the command
	command := strings.TrimSpace(fields[1])

	// Add a space after the command so the user can type arguments right away
	fmt.Println(command + " ")

	// If the last field is x then execute the command
	lastField := fields[len(fields)-1]
	if strings.TrimSpace(lastField) == "x" {
		fmt.Println()
	}
}

func main() {
	filePath := parseFlags()
	commands := readFile(filePath)

	fzfOutput, err := runFzf(commands)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}

	// Split the fzf output into lines
	lines := strings.Split(fzfOutput, "\n")

	formatFzfOutput(lines)
}
