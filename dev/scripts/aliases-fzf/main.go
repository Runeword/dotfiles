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
	var aliasesFile string

	flag.StringVar(&aliasesFile, "f", "", "Aliases file path")
	flag.Parse()

	if aliasesFile == "" {
		fmt.Fprintln(os.Stderr, "Error: aliases file path is required")
		os.Exit(1)
	}

	return aliasesFile
}

func readFile(filepath string) []string {
	file, err := os.Open(filepath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error opening file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	var commands []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if line == "" || strings.HasPrefix(line, "# ") {
			continue
		}
		commands = append(commands, line)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintf(os.Stderr, "Error reading file: %v\n", err)
		os.Exit(1)
	}

	return commands
}

func createFzfCommand() (*exec.Cmd) {
	return exec.Command("fzf",
		"--with-nth=1,2,3",
		"--print-query",
		"--query=^",
		"--exact",
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

func selectCommand(aliases []string) (string, error) {
	fzf := createFzfCommand()
	fzf.Stderr = os.Stderr

	stdin, err := fzf.StdinPipe()
	if err != nil {
		return "", fmt.Errorf("error creating stdin pipe: %v", err)
	}

	go func() {
		defer stdin.Close()
		for _, alias := range aliases {
			fmt.Fprintln(stdin, alias)
		}
	}()

	output, err := fzf.Output()
	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			os.Exit(0)
		}
		return "", fmt.Errorf("error running fzf: %v", err)
	}

	return string(output), nil
}

func processFzfOutput(output string) {
	lines := strings.Split(output, "\n")
	if len(lines) == 0 {
		return
	}

	if len(lines) <= 2 && lines[0] != "" {
		query := strings.TrimPrefix(lines[0], "^")
		query = strings.Map(func(r rune) rune {
			if unicode.IsLetter(r) {
				return r
			}
			return -1
		}, query)
		fmt.Print(query)
		return
	}

	selected := lines[1]
	fields := strings.Split(selected, "\t")
	if len(fields) < 2 {
		return
	}

	command := strings.TrimSpace(fields[1])
	fmt.Print(command + " ")

	if len(fields) > 3 && strings.TrimSpace(fields[len(fields)-1]) == "x" {
		fmt.Print("\n")
	}
}

func main() {
	filePath := parseFlags()
	commands := readFile(filePath)

	output, err := selectCommand(commands)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
	processFzfOutput(output)
}
