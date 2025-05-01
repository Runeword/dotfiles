package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func getArgs() []string {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Usage: chezmoi-fzf <cmd> [args...]")
		os.Exit(1)
	}
	return os.Args[1:]
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

func executeChezmoiCommand(args []string) error {
	execCmd := exec.Command("chezmoi", args...)
	execCmd.Stdout = os.Stdout
	execCmd.Stderr = os.Stderr
	return execCmd.Run()
}

func chezmoiWrapper() error {
	args := getArgs()
	if len(args) == 1 {
		targets, err := selectChezmoiTargets(args[0])
		if err != nil {
			return err
		}
		args = append(args, targets...)
	}
	return executeChezmoiCommand(args)
}

func main() {
	if err := chezmoiWrapper(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
