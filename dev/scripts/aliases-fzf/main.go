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
		"--nth=1",
		"--exit-0",
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

func selectCommand(commands []string) (string, error) {
	fzf := createFzfCommand()
	fzf.Stderr = os.Stderr

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

	output, err := fzf.Output()
	if err != nil {
		// Exit if user pressed Ctrl+C
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			os.Exit(0)
		}
		// Else return the error
		return "", fmt.Errorf("error running fzf: %v", err)
	}

	return string(output), nil
}

func processFzfOutput(output string) {
	lines := strings.Split(output, "\n")
	if len(lines) == 0 {
		return
	}

	// If we have a query (first line) but no selection (second line is empty),
	// it means no matches were found, so return the query
	if len(lines) == 1 || lines[1] == "" {
		queryString := strings.TrimPrefix(lines[0], "^")
		queryString = strings.Map(func(r rune) rune {
			if unicode.IsLetter(r) {
				return r
			}
			return -1
		}, queryString)
		fmt.Print(queryString)
		return
	}

	// If we have a selection, process it
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

	selectedCommand, err := selectCommand(commands)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}

	processFzfOutput(selectedCommand)
}
