#!/bin/sh

__open_file() {
	# Preview of focussed file or folder
	__preview_cmd() {
		if [ -d "$1" ]; then
			tree -Ca -L 2 "$1"
		else
			command -v bat >/dev/null && bat --style=plain --color=always "$1" || cat "$1"
		fi | head -n $FZF_PREVIEW_LINES
	}

	# Find then select file(s)
	local selected_files=$(
		find . \
			\( -path './.git' -o -path './flake-inputs' -o -path './.nix-defexpr' \
			-o -path './.nix-profile' -o -path './node_modules' -o -path './.local' \) \
			-prune -o -printf '%P\n' |
			tail -n +2 |
			fzf --multi --inline-info --cycle --height 70% --ansi \
				--preview "$(typeset -f __preview_cmd); __preview_cmd {}" \
				--preview-window right,50%,border-left --no-scrollbar
	)

	# If no selection do nothing
	[ -z "$selected_files" ] && return 0

	# Check the number of selected files
	local num_lines=$(echo "$selected_files" | wc -l)

	# If single directory selection
	if [ "$num_lines" -eq 1 ] && [ -d "$selected_files" ]; then
		# Then cd into it
		if cd $selected_files; then
			history -s "cd $selected_files"
		else
			echo "Error: could not change directory to $selected_files"
			return 1
		fi
	else # If single or multiple file selection
		# Then open it in editor
		if $EDITOR $selected_files; then
			history -s "$EDITOR $selected_files"
		else
			echo "Error: could not open $selected_files with $EDITOR"
			return 1
		fi
	fi
}
