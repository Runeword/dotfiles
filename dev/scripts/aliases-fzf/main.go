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

	// Create a pipe connected to the fzf standard input
	fzfStdin, err := fzf.StdinPipe()
	if err != nil {
		return "", fmt.Errorf("error creating stdin pipe: %v", err)
	}

	// Writes all commands to the fzf standard input in a goroutine
	go func() {
		// Ensures the pipe is closed after writing commands
		defer fzfStdin.Close()
		for _, command := range commands {
			// Write command to the fzf standard input
			fmt.Fprintln(fzfStdin, command)
		}
	}()

	// 2. Execute fzf
	output, err := fzf.Output()

	// 3. Handle fzf errors

	if exitErr, ok := err.(*exec.ExitError); ok {
		// If user pressed Ctrl+C
		if exitErr.ExitCode() == 130 {
			os.Exit(0)
		}
		// If there was no matches
		if exitErr.ExitCode() == 1 {
			return string(output), nil
		}
		// If there was an error
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

func formatFzfSelection(fzfSelection string) string {
	var output string

	// Extract fields from fzf selection
	fields := strings.Split(fzfSelection, "\t")

	// If no command field
	if len(fields) < 2 {
		output = ""
	}

	// Remove leading and trailing spaces from the command
	command := strings.TrimSpace(fields[1])

	// Add a space after the command so the user can type arguments right away
	output = command + " "

	// If the last field is x then execute the command
	lastField := fields[len(fields)-1]
	if strings.TrimSpace(lastField) == "x" {
		output = "\n"
	}
	return output
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

	// If no fzf selection (line 1) then format and print the fzf query (line 0)
	if lines[1] == "" {
		fmt.Println(formatFzfQuery(lines[0]))
		return
	}

	// Else format and print the fzf selection (line 1)
	fmt.Println(formatFzfSelection(lines[1]))
}
