package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func selectFiles(files string, header string) (string, error) {
	cmd := exec.Command("fzf",
		"--multi",
		"--reverse",
		"--no-separator",
		"--border", "none",
		"--cycle",
		"--height", "100%",
		"--info=inline:''",
		"--header-first",
		"--prompt='  '",
		"--scheme=path",
		"--header="+header,
		"--bind=ctrl-a:select-all",
		"--preview", "chezmoi diff --reverse --color=true ~/{}",
		"--preview-window", "bottom,80%,noborder",
	)

	cmd.Stdin = strings.NewReader(files)
	cmd.Stderr = os.Stderr
	output, err := cmd.Output()
	if err != nil {
		return "", err
	}
	return strings.TrimSpace(string(output)), nil
}

func chezmoi(operation string, args []string) error {
	var selectedFiles string
	if len(args) > 0 {
		selectedFiles = strings.Join(args, " ")
	} else {
		cmd := exec.Command("chezmoi", "status")
		output, err := cmd.Output()
		if err != nil {
			return err
		}

		scanner := bufio.NewScanner(strings.NewReader(string(output)))
		var files []string
		for scanner.Scan() {
			fields := strings.Fields(scanner.Text())
			if len(fields) >= 2 {
				files = append(files, fields[1])
			}
		}

		if len(files) == 0 {
			return fmt.Errorf("no files to process")
		}

		selectedFiles, err = selectFiles(strings.Join(files, "\n"), "chezmoi "+operation)
		if err != nil {
			return err
		}
		if selectedFiles == "" {
			return fmt.Errorf("no files selected")
		}
	}

	for _, file := range strings.Fields(selectedFiles) {
		cmd := exec.Command("chezmoi", operation, os.ExpandEnv("$HOME/"+file))
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			return err
		}
	}

	return nil
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Usage: chezmoi-fzf <operation> [files...]")
		os.Exit(1)
	}

	operation := os.Args[1]
	if err := chezmoi(operation, os.Args[2:]); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
