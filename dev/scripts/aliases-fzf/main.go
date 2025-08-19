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

func main() {
	fzf := createFzfCommand()

	// Pipe any error messages from the fzf command directly to the terminal,
	// so users can see any error messages or warnings that fzf might output
	fzf.Stderr = os.Stderr

	// Feed fzf
	writeToFzfStdin(fzf, readFile())

	// Run fzf
	output, err := fzf.Output()
	if err != nil {
		output = []byte(handleFzfError(err, output))
	}

	// Split output
	lines := strings.Split(string(output), "\n")

	// If no fzf selection (line 1)
	if lines[1] == "" {
		// Then format and print the fzf query (line 0)
		fmt.Println(formatFzfQuery(lines[0]))
		return
	}

	// Else format and print the fzf selection (line 1)
	fmt.Println(formatFzfSelection(lines[1]))
}

func readFile() []string {
	// Get filePath
	var filePath string
	flag.StringVar(&filePath, "f", "", "Commands file path")
	flag.Parse()

	if filePath == "" {
		fmt.Fprintln(os.Stderr, "Error: commands file path is required")
		os.Exit(1)
	}

	// Open file at given path
	file, err := os.Open(filePath)
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

func writeToFzfStdin(fzf *exec.Cmd, commands []string) {
	// Create a pipe connected to the fzf standard input
	fzfStdin, err := fzf.StdinPipe()
	if err != nil {
		fmt.Fprintf(os.Stderr, "error creating stdin pipe: %v\n", err)
		os.Exit(1)
	}

	// Write all commands to the fzf standard input in a goroutine
	go func() {
		defer fzfStdin.Close()
		for _, command := range commands {
			fmt.Fprintln(fzfStdin, command)
		}
	}()
}

func handleFzfError(err error, output []byte) string {
	if exitErr, ok := err.(*exec.ExitError); ok {
		// If user pressed Ctrl+C
		if exitErr.ExitCode() == 130 {
			os.Exit(0)
		}
		// If there was no matches
		if exitErr.ExitCode() == 1 {
			return string(output)
		}
	}
	return ""
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
	// Extract fields from fzf selection
	fields := strings.Split(fzfSelection, "\t")

	// If no command field
	if len(fields) < 2 {
		return ""
	}

	// Remove leading and trailing spaces from the command
	command := strings.TrimSpace(fields[1])

	// Add a space after the command so the user can type arguments right away
	command += " "

	// If the last field is x then execute the command
	if len(fields) > 2 {
		lastField := strings.TrimSpace(fields[len(fields)-1])
		if lastField == "x" {
			command += "\n"
		}
	}

	return command
}
