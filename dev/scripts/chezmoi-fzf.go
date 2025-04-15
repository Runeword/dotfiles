package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func getArgs() (cmd string, files []string, flags[]string, error error) {
	flag.Parse()
	args := flag.Args()
	if len(args) < 1 {
		return "", nil, nil, fmt.Errorf("Usage: chezmoi-fzf <chezmoi-cmd> [files...] [flags...]")
	}

	cmd = args[0]

	for i := 1; i < len(args); i++ {
		if strings.HasPrefix(args[i], "-") {
			flags = append(flags, args[i])
		} else {
			files = append(files, args[i])
		}
	}

	return cmd, files, flags, nil
}

func selectFiles(paths string, header string) (targets string, error error) {
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

	cmd.Stdin = strings.NewReader(paths)
	cmd.Stderr = os.Stderr
	output, err := cmd.Output()
	if err != nil {
		return "", err
	}
	return strings.TrimSpace(string(output)), nil
}

func getFiles() (files []string, error error) {
	cmd := exec.Command("chezmoi", "status")
	output, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	scanner := bufio.NewScanner(strings.NewReader(string(output)))
	for scanner.Scan() {
		fields := strings.Fields(scanner.Text())
		if len(fields) >= 2 {
			files = append(files, fields[1])
		}
	}

	if len(files) == 0 {
		return nil, fmt.Errorf("no files to process")
	}

	return files, nil
}

func selectPaths(cmd string) (selectedFiles string, error error) {
	files, err := getFiles()

	if err != nil {
		return "", err
	}

	selectedFiles, err = selectFiles(strings.Join(files, "\n"), cmd)
	if err != nil {
		return "", err
	}

	if selectedFiles == "" {
		return "", fmt.Errorf("no files selected")
	}

	return
}

func executeChezmoiCommand(cmd string, flags []string, path string) error {
	fullPath := os.ExpandEnv("$HOME/" + path)

	command := exec.Command(cmd, append(flags, fullPath)...)
	command.Stdout = os.Stdout
	command.Stderr = os.Stderr

	return command.Run()
}

func chezmoi() error {
	cmd, targets, flags, err := getArgs()
	if err != nil {
		return err
	}

	paths := strings.Join(targets, " ")
	if paths == "" {
		paths, err = selectPaths(cmd)
		if err != nil {
			return err
		}
	}

	for _, path := range strings.Fields(paths) {
		if err := executeChezmoiCommand(cmd, flags, path); err != nil {
			return err
		}
	}

	return nil
}

func main() {
	if err := chezmoi(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
