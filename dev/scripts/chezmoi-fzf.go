package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func getArgs() (cmd string, flags []string, targets []string, err error) {
	args := os.Args[1:]

	if len(args) < 1 {
		return "", nil, nil, fmt.Errorf("Usage: chezmoi-fzf <cmd> [flags...] [targets...]")
	}

	cmd = args[0]

	for i := 1; i < len(args); i++ {
		if strings.HasPrefix(args[i], "-") {
			flags = append(flags, args[i])
		} else {
			targets = append(targets, args[i])
		}
	}

	return cmd, flags, targets, nil
}

func getModifiedFiles() (files []string, err error) {
	statusCmd := exec.Command("chezmoi", "status")
	output, err := statusCmd.Output()
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

func createFzfCommand(chezmoiCmd string) *exec.Cmd {
	return exec.Command("fzf",
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
		"--header="+chezmoiCmd,
		"--bind=ctrl-a:select-all",
		"--preview", "chezmoi diff --reverse --color=true ~/{}",
		"--preview-window", "bottom,80%,noborder",
	)
}

func selectChezmoiTargets(cmd string) ([]string, error) {
	files, err := getModifiedFiles()
	if err != nil {
		return nil, err
	}

	fzf := createFzfCommand(cmd)
	fzf.Stdin = strings.NewReader(strings.Join(files, "\n"))
	fzf.Stderr = os.Stderr

	output, err := fzf.Output()
	if err != nil {
		return nil, err
	}

	selectedTargets := strings.TrimSpace(string(output))
	if selectedTargets == "" {
		return nil, fmt.Errorf("no files selected")
	}

	return strings.Fields(selectedTargets), nil
}

func executeChezmoiCommand(cmd string, target string, flags []string) error {
	args := append([]string{cmd}, flags...)
	args = append(args, os.ExpandEnv("$HOME/"+target))

	execCmd := exec.Command("chezmoi", args...)
	execCmd.Stdout = os.Stdout
	execCmd.Stderr = os.Stderr

	return execCmd.Run()
}

func chezmoiWrapper() error {
	cmd, flags, targets, err := getArgs()
	if err != nil {
		return err
	}

	// fmt.Println(cmd, flags, targets)
	// os.Exit(1)

	if len(targets) == 0 {
		selectedTargets, err := selectChezmoiTargets(cmd)
		if err != nil {
			return err
		}
		targets = selectedTargets
	}

	for _, target := range targets {
		if err := executeChezmoiCommand(cmd, target, flags); err != nil {
			return err
		}
	}

	return nil
}

func main() {
	if err := chezmoiWrapper(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
