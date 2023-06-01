#!/bin/sh

preview_cmd='if [ -d {} ]; then
                tree -Ca -L 2 {};
             else
                bat --style=plain --color=always {};
             fi | head -$FZF_PREVIEW_LINES'

o () {
  selected_files=$(
    fd --hidden \
      --follow \
      --no-ignore \
      --exclude .git \
      --exclude flake-inputs \
      --exclude .nix-defexpr \
      --exclude .nix-profile \
      --exclude node_modules \
      --exclude .local \
      | fzf --multi --inline-info --cycle --height 70% --ansi \
      --preview "$preview_cmd" \
    --preview-window right,50%,noborder --no-scrollbar
  )
  if [ -d $selected_files ]
  then cd $selected_files
  elif [ -f $selected_files ]
  then $EDITOR $selected_files
  fi
  return 1
}

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
