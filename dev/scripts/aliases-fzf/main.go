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

func main() {
	var prefixChar string
	var aliasesFile string

	flag.StringVar(&prefixChar, "p", "", "Prefix character")
	flag.StringVar(&aliasesFile, "f", "", "Aliases file path")
	flag.Parse()

	if aliasesFile == "" {
		fmt.Fprintln(os.Stderr, "Error: aliases file path is required")
		os.Exit(1)
	}

	file, err := os.Open(aliasesFile)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error opening file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	var aliases []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if line == "" {
			continue
		}
		aliases = append(aliases, line)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintf(os.Stderr, "Error reading file: %v\n", err)
		os.Exit(1)
	}

	options := []string{
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
	}

	cmd := exec.Command("fzf", options...)
	cmd.Stderr = os.Stderr

	stdin, err := cmd.StdinPipe()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error creating stdin pipe: %v\n", err)
		os.Exit(1)
	}

	go func() {
		defer stdin.Close()
		for _, alias := range aliases {
			fmt.Fprintln(stdin, alias)
		}
	}()

	output, err := cmd.Output()
	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			os.Exit(0)
		}
		fmt.Fprintf(os.Stderr, "Error running fzf: %v\n", err)
		os.Exit(1)
	}

	outputStr := string(output)
	lines := strings.Split(outputStr, "\n")
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
