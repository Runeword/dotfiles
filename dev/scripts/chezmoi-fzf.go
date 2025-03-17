package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

// Common FZF options
const (
	fzfCommonOpts = "--multi --reverse --no-separator --border none --cycle --info=inline --header-first --prompt=  --scheme=path --bind=ctrl-a:select-all"
)

// Command represents a chezmoi command
type Command struct {
	Name   string
	Action func([]string) error
}

func main() {
	if len(os.Args) < 2 {
		printUsage()
		os.Exit(1)
	}

	commands := map[string]Command{
		"add": {
			Name:   "add",
			Action: chezmoiAdd,
		},
		"apply": {
			Name:   "apply",
			Action: chezmoiApply,
		},
		"status": {
			Name:   "status",
			Action: chezmoiStatus,
		},
		"managed": {
			Name:   "managed",
			Action: chezmoiManaged,
		},
		"forget": {
			Name:   "forget",
			Action: chezmoiForget,
		},
	}

	cmd := os.Args[1]
	if command, ok := commands[cmd]; ok {
		var args []string
		if len(os.Args) > 2 {
			args = os.Args[2:]
		}
		err := command.Action(args)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", err)
			os.Exit(1)
		}
	} else {
		fmt.Fprintf(os.Stderr, "Unknown command: %s\n", cmd)
		printUsage()
		os.Exit(1)
	}
}

func printUsage() {
	fmt.Println("Usage: chezmoi-fzf <command> [args]")
	fmt.Println("\nCommands:")
	fmt.Println("  add      Add files to chezmoi")
	fmt.Println("  apply    Apply changes to files")
	fmt.Println("  status   Show status of files and open in editor")
	fmt.Println("  managed  Select and edit files managed by chezmoi")
	fmt.Println("  forget   Forget files from chezmoi")
}

// selectFilesWithDiff selects files using fzf with diff preview
func selectFilesWithDiff(files []string, header string) ([]string, error) {
	if len(files) == 0 {
		return nil, fmt.Errorf("no files to select")
	}

	fzfArgs := []string{
		"--height", "100%",
		"--header", header,
		"--preview", "chezmoi diff --reverse --color=true ~/{}",
		"--preview-window", "bottom,80%,noborder",
	}

	// Add common options
	for _, opt := range strings.Split(fzfCommonOpts, " ") {
		if opt != "" {
			fzfArgs = append(fzfArgs, opt)
		}
	}

	fzfCmd := exec.Command("fzf", fzfArgs...)

	fzfCmd.Stdin = strings.NewReader(strings.Join(files, "\n"))
	fzfCmd.Stderr = os.Stderr

	var out bytes.Buffer
	fzfCmd.Stdout = &out

	err := fzfCmd.Run()
	if err != nil {
		// Exit code 130 means user canceled selection (Ctrl+C)
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			return nil, nil
		}
		return nil, err
	}

	var selected []string
	scanner := bufio.NewScanner(&out)
	for scanner.Scan() {
		selected = append(selected, scanner.Text())
	}

	return selected, nil
}

// selectFilesWithPreview selects files using fzf with file content preview
func selectFilesWithPreview(files []string, header string) ([]string, error) {
	if len(files) == 0 {
		return nil, fmt.Errorf("no files to select")
	}

	fzfArgs := []string{
		"--height", "70%",
		"--header", header,
		"--preview", "bat --style=plain --color=always {} 2>/dev/null || cat {}",
		"--preview-window", "right,70%,noborder",
	}

	// Add common options
	for _, opt := range strings.Split(fzfCommonOpts, " ") {
		if opt != "" {
			fzfArgs = append(fzfArgs, opt)
		}
	}

	fzfCmd := exec.Command("fzf", fzfArgs...)

	fzfCmd.Stdin = strings.NewReader(strings.Join(files, "\n"))
	fzfCmd.Stderr = os.Stderr

	var out bytes.Buffer
	fzfCmd.Stdout = &out

	err := fzfCmd.Run()
	if err != nil {
		// Exit code 130 means user canceled selection (Ctrl+C)
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			return nil, nil
		}
		return nil, err
	}

	var selected []string
	scanner := bufio.NewScanner(&out)
	for scanner.Scan() {
		selected = append(selected, scanner.Text())
	}

	return selected, nil
}

// getChezmoiStatus gets the status of files from chezmoi
func getChezmoiStatus() ([]string, error) {
	cmd := exec.Command("chezmoi", "status")
	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		return nil, err
	}

	var files []string
	scanner := bufio.NewScanner(&out)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Fields(line)
		if len(parts) >= 2 {
			files = append(files, parts[1])
		}
	}

	return files, nil
}

// getChezmoiManaged gets the list of files managed by chezmoi
func getChezmoiManaged() ([]string, error) {
	cmd := exec.Command("chezmoi", "managed", "--include=files")
	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		return nil, err
	}

	var files []string
	scanner := bufio.NewScanner(&out)
	for scanner.Scan() {
		files = append(files, scanner.Text())
	}

	return files, nil
}

// chezmoiAdd adds files to chezmoi
func chezmoiAdd(args []string) error {
	var filesToAdd []string

	if len(args) > 0 {
		filesToAdd = args
	} else {
		files, err := getChezmoiStatus()
		if err != nil {
			return err
		}

		filesToAdd, err = selectFilesWithDiff(files, "chezmoi add")
		if err != nil {
			return err
		}

		if len(filesToAdd) == 0 {
			return nil // User canceled or no files selected
		}
	}

	for _, file := range filesToAdd {
		homeDir, err := os.UserHomeDir()
		if err != nil {
			return err
		}
		fullPath := filepath.Join(homeDir, file)

		cmd := exec.Command("chezmoi", "add", fullPath)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		err = cmd.Run()
		if err != nil {
			return err
		}
	}

	return nil
}

// chezmoiApply applies changes to files
func chezmoiApply(args []string) error {
	var filesToApply []string

	if len(args) > 0 {
		filesToApply = args
	} else {
		files, err := getChezmoiStatus()
		if err != nil {
			return err
		}

		filesToApply, err = selectFilesWithDiff(files, "chezmoi apply")
		if err != nil {
			return err
		}

		if len(filesToApply) == 0 {
			return nil // User canceled or no files selected
		}
	}

	for _, file := range filesToApply {
		homeDir, err := os.UserHomeDir()
		if err != nil {
			return err
		}
		fullPath := filepath.Join(homeDir, file)

		cmd := exec.Command("chezmoi", "apply", fullPath)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		err = cmd.Run()
		if err != nil {
			return err
		}
	}

	return nil
}

// chezmoiStatus shows status of files and opens them in editor
func chezmoiStatus(args []string) error {
	files, err := getChezmoiStatus()
	if err != nil {
		return err
	}

	selected, err := selectFilesWithDiff(files, "chezmoi status")
	if err != nil {
		return err
	}

	if len(selected) == 0 {
		return nil // User canceled or no files selected
	}

	editor := os.Getenv("EDITOR")
	if editor == "" {
		editor = "vim" // Default editor
	}

	editorCmd := exec.Command(editor, selected...)
	editorCmd.Stdin = os.Stdin
	editorCmd.Stdout = os.Stdout
	editorCmd.Stderr = os.Stderr

	return editorCmd.Run()
}

// chezmoiManaged selects and edits files managed by chezmoi
func chezmoiManaged(args []string) error {
	files, err := getChezmoiManaged()
	if err != nil {
		return err
	}

	selected, err := selectFilesWithPreview(files, "chezmoi managed --include=files")
	if err != nil {
		return err
	}

	if len(selected) == 0 {
		return nil // User canceled or no files selected
	}

	editor := os.Getenv("EDITOR")
	if editor == "" {
		editor = "vim" // Default editor
	}

	editorCmd := exec.Command(editor, selected...)
	editorCmd.Stdin = os.Stdin
	editorCmd.Stdout = os.Stdout
	editorCmd.Stderr = os.Stderr

	return editorCmd.Run()
}

// chezmoiForget forgets files from chezmoi
func chezmoiForget(args []string) error {
	var filesToForget []string

	if len(args) > 0 {
		filesToForget = args
	} else {
		files, err := getChezmoiManaged()
		if err != nil {
			return err
		}

		filesToForget, err = selectFilesWithPreview(files, "chezmoi forget")
		if err != nil {
			return err
		}

		if len(filesToForget) == 0 {
			return nil // User canceled or no files selected
		}
	}

	for _, file := range filesToForget {
		homeDir, err := os.UserHomeDir()
		if err != nil {
			return err
		}
		fullPath := filepath.Join(homeDir, file)

		cmd := exec.Command("chezmoi", "forget", fullPath)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr

		err = cmd.Run()
		if err != nil {
			return err
		}
	}

	return nil
}
