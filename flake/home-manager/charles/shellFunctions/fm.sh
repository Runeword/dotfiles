#!/bin/sh

__preview_cmd() {
	if [ -d "$1" ]; then
		tree -Ca -L 2 "$1"
	else
		bat --style=plain --color=always "$1"
	fi | head -n $FZF_PREVIEW_LINES
}

export -f __preview_cmd

open_file() {
	selected_files=$(
		find . \
			\( -path './.git' -o -path './flake-inputs' -o -path './.nix-defexpr' \
			-o -path './.nix-profile' -o -path './node_modules' -o -path './.local' \) \
			-prune -o -printf '%P\n' |
			tail -n +2 |
			fzf --multi --inline-info --cycle --height 70% --ansi \
				--preview "__preview_cmd {}" \
				--preview-window right,50%,noborder --no-scrollbar
	)

	num_lines=$(echo "$selected_files" | wc -l)

	if [ -z "$selected_files" ]; then
		return 0
	elif [ "$num_lines" -eq 1 ] && [ -d "$selected_files" ]; then
		history -s "cd $selected_files"
		cd $selected_files
	else
		history -s $EDITOR $selected_files
		$EDITOR $selected_files
	fi
}
