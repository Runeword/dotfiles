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
			fzf --multi --inline-info --cycle --height 70% --ansi \
				--preview "__preview_cmd {}" \
				--preview-window right,50%,noborder --no-scrollbar
	)

	if [ -z "$selected_files" ]; then
		return 1
	elif [ -d $selected_files ]; then
		cd $selected_files
		history -s "cd $selected_files"
	elif [ -f $selected_files ]; then
		$EDITOR $selected_files
		history -s "$EDITOR $selected_files"
	fi

	return 1
}

# fd --hidden \
#   --follow \
#   --no-ignore \
#   --exclude .git \
#   --exclude flake-inputs \
#   --exclude .nix-defexpr \
#   --exclude .nix-profile \
#   --exclude node_modules \
#   --exclude .local |
# --preview "$(preview_cmd {})" \
# --preview "$preview_cmd" \
# --preview 'if [ -d {} ]; then tree -Ca -L 2 {}; else bat --style=plain --color=always {}; fi | head -$FZF_PREVIEW_LINES' \
# if [ -d {} ]; then tree -Ca -L 2 {}; else bat --style=plain --color=always {}; fi | head -$FZF_PREVIEW_LINES
# --bind 'enter:execute(if [ -d {} ]; then cd {}; else $EDITOR {}; fi)+abort' \
# --preview 'tree -Ca -L 2 {} | head -$FZF_PREVIEW_LINES' \
# --bind='enter:execute(if [ -d {} ]; then cd {}; else $EDITOR {}; fi)+abort' \

# --preview 'ls -AxF {} | head -$FZF_PREVIEW_LINES' \
# nfu () {
#   flake_path=${1-$HOME/flake}
#   flake_metadata=$(nix flake metadata "$flake_path" --json)
#
#   inputs=$(echo "$flake_metadata" | jq --raw-output '.locks.nodes.root.inputs | keys[]')
#   [ -z "$inputs" ] && return 1
#
#   selected_inputs=$(echo "$inputs" | fzf \
#     --multi --inline-info --cycle --height 70% \
#     --preview "echo '$flake_metadata' | jq --color-output '.locks.nodes.\"{}\"'" \
#     --preview-window right,75%,noborder
# )
#   [ -z "$selected_inputs" ] && return 1
#
#   for i in $selected_inputs; do
#     nix flake lock --update-input "$i" "$flake_path"
#   done
# }
