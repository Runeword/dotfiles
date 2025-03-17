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

// runFzf runs fzf with the given options and returns selected items
func runFzf(files []string, header, preview, previewPos string, height string) ([]string, error) {
	if len(files) == 0 {
		return nil, fmt.Errorf("no files to select")
	}

	fzfArgs := []string{
		"--height", height,
		"--header", header,
		"--preview", preview,
		"--preview-window", previewPos + ",noborder",
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

// selectFilesWithDiff selects files using fzf with diff preview
func selectFilesWithDiff(files []string, header string) ([]string, error) {
	preview := "chezmoi diff --reverse --color=true ~/{}"
	previewPos := "bottom,80%"
	return runFzf(files, header, preview, previewPos, "100%")
}

// selectFilesWithPreview selects files using fzf with file content preview
func selectFilesWithPreview(files []string, header string) ([]string, error) {
	preview := "bat --style=plain --color=always {} 2>/dev/null || cat {}"
	previewPos := "right,70%"
	return runFzf(files, header, preview, previewPos, "70%")
}

// runCommand runs a command with given args and streams output
func runCommand(cmd string, args ...string) error {
	command := exec.Command(cmd, args...)
	command.Stdout = os.Stdout
	command.Stderr = os.Stderr
	return command.Run()
}

// runWithOutput runs a command and returns its output
func runWithOutput(cmd string, args ...string) ([]string, error) {
	command := exec.Command(cmd, args...)
	var out bytes.Buffer
	command.Stdout = &out
	command.Stderr = os.Stderr

	err := command.Run()
	if err != nil {
		return nil, err
	}

	var lines []string
	scanner := bufio.NewScanner(&out)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	return lines, nil
}

// getChezmoiStatus gets the status of files from chezmoi
func getChezmoiStatus() ([]string, error) {
	output, err := runWithOutput("chezmoi", "status")
	if err != nil {
		return nil, err
	}

	var files []string
	for _, line := range output {
		parts := strings.Fields(line)
		if len(parts) >= 2 {
			files = append(files, parts[1])
		}
	}

	return files, nil
}

// getChezmoiManaged gets the list of files managed by chezmoi
func getChezmoiManaged() ([]string, error) {
	return runWithOutput("chezmoi", "managed", "--include=files")
}

// openInEditor opens the selected files in the user's editor
func openInEditor(selected []string) error {
	if len(selected) == 0 {
		return nil // User canceled or no files selected
	}

	editor := os.Getenv("EDITOR")
	if editor == "" {
		editor = "vim" // Default editor
	}

	return runCommand(editor, selected...)
}

// getHomePaths converts relative paths to absolute paths in the home directory
func getHomePaths(files []string) ([]string, error) {
	if len(files) == 0 {
		return nil, nil
	}

	homeDir, err := os.UserHomeDir()
	if err != nil {
		return nil, err
	}

	var paths []string
	for _, file := range files {
		paths = append(paths, filepath.Join(homeDir, file))
	}
	return paths, nil
}
// processChezmoiFiles handles the common pattern of getting files,
// selecting them with fzf, and running a chezmoi command on them
func processChezmoiFiles(getFilesFn func() ([]string, error), selectFn func([]string, string) ([]string, error),
	header string, cmdName string, needsHomePath bool) error {
	files, err := getFilesFn()
	if err != nil {
		return err
	}

	selected, err := selectFn(files, header)
	if err != nil {
		return err
	}

	if len(selected) == 0 {
		return nil // User canceled or no files selected
	}

	if needsHomePath {
		paths, err := getHomePaths(selected)
		if err != nil {
			return err
		}

		for _, path := range paths {
			err = runCommand("chezmoi", cmdName, path)
			if err != nil {
				return err
			}
		}
		return nil
	}

	// If we don't need to prepend home path, just run the command directly on selected files
	cmdArgs := append([]string{cmdName}, selected...)
	return runCommand("chezmoi", cmdArgs...)
}

// chezmoiAdd adds files to chezmoi
func chezmoiAdd(args []string) error {
	if len(args) > 0 {
		// If args provided, use them directly
		paths, err := getHomePaths(args)
		if err != nil {
			return err
		}

		for _, path := range paths {
			err = runCommand("chezmoi", "add", path)
			if err != nil {
				return err
			}
		}
		return nil
	}

	return processChezmoiFiles(getChezmoiStatus, selectFilesWithDiff, "chezmoi add", "add", true)
}

// chezmoiApply applies changes to files
func chezmoiApply(args []string) error {
	if len(args) > 0 {
		// If args provided, use them directly
		paths, err := getHomePaths(args)
		if err != nil {
			return err
		}

		for _, path := range paths {
			err = runCommand("chezmoi", "apply", path)
			if err != nil {
				return err
			}
		}
		return nil
	}

	return processChezmoiFiles(getChezmoiStatus, selectFilesWithDiff, "chezmoi apply", "apply", true)
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

	return openInEditor(selected)
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

	return openInEditor(selected)
}

// chezmoiForget forgets files from chezmoi
func chezmoiForget(args []string) error {
	if len(args) > 0 {
		// If args provided, use them directly
		paths, err := getHomePaths(args)
		if err != nil {
			return err
		}

		for _, path := range paths {
			err = runCommand("chezmoi", "forget", path)
			if err != nil {
				return err
			}
		}
		return nil
	}

	return processChezmoiFiles(getChezmoiManaged, selectFilesWithPreview, "chezmoi forget", "forget", true)
}

