#!/bin/sh

__open_file() {
  # Select file(s) with fzf
  local selected_files
  selected_files=$(
    find . \
      \( -path './.git' -o -path './flake-inputs' -o -path './.nix-defexpr' \
      -o -path './.nix-profile' -o -path './node_modules' -o -path './.local' -o -path './.direnv' \) \
      -prune -o -printf '%P\n' 2> /dev/null |
      tail -n +2 |
      fzf \
        --multi \
        --reverse \
        --border none \
        --cycle \
        --height 70% \
        --ansi \
        --preview "$HOME/home-manager/charles/sh/scripts/fm_preview.sh {}" \
        --preview-window right,55%,border-none,~1 \
        --bind='ctrl-y:execute-silent(wl-copy {})'
  )

  # If no selection do nothing
  [ "$selected_files" = "" ] && return 0

  # Check number of selected files
  local num_lines
  num_lines="$(echo "$selected_files" | wc -l)"

  # cd into single directory
  if [ "$num_lines" -eq 1 ] && [ -d "$selected_files" ]; then
    if ! cd "$selected_files"; then
      echo "Fail: could not change directory to $selected_files"
      return 1
    fi

    # Then write command in history
    [ "$BASH_VERSION" != "" ] && history -s "cd $selected_files"
    [ "$ZSH_VERSION" != "" ] && print -s "cd $selected_files"
  else
    # else open files selection in editor
    if ! echo "$selected_files" | xargs "$EDITOR"; then
      echo "Fail: could not open $selected_files with $EDITOR"
      return 1
    fi

    # Then write command in history
    [ "$BASH_VERSION" != "" ] && history -s "$EDITOR $(echo "$selected_files" | xargs)"
    [ "$ZSH_VERSION" != "" ] && print -s "$EDITOR $(echo "$selected_files" | xargs)"
  fi

  return 0
}

__ripgrep() {
  # local selected_files=$(
  rg \
    --color always \
    --colors 'path:none' \
    --colors 'line:none' \
    --colors 'match:none' \
    --colors 'line:fg:red' \
    --line-number \
    --no-heading \
    --smart-case "${*:-}" |
    fzf \
      --ansi \
      --multi \
      --delimiter : \
      --reverse \
      --border none \
      --cycle \
      --info=inline:'' \
      --height 70% \
      --no-separator \
      --preview 'bat --style=plain --color=always {1} --highlight-line {2}' \
      --preview-window 'right,55%,border-none,+{2}+3/3,~3' \
      --bind 'enter:become(nvim {1} +{2})'
  # )
  # --bind 'enter:execute(echo {1} +{2})+abort'
  # echo $selected_files

  # # If no selection do nothing
  # [ -z "$selected_files" ] && return 0
  #
  # # Check the number of selected files
  # local num_lines=$(echo "$selected_files" | wc -l)
  #
  # # Open files in editor
  # if $EDITOR $selected_files; then
  # 	history -s "$EDITOR $selected_files"
  # else
  # 	echo "Error: could not open $selected_files with $EDITOR"
  # 	return 1
  # fi
}

# --color "hl:-1:underline,hl+:-1:underline:reverse" \
# --bind 'enter:become(vim {1} +{2})'
# "cd $(fd --type directory --hidden --follow --no-ignore --exclude .git --exclude node_modules | fzf --inline-info --cycle --preview 'ls -AxF {} | head -$FZF_PREVIEW_LINES' --preview-window right,50%,noborder --no-scrollbar)";
# "cd $(fd --type directory --hidden --follow --no-ignore | fzf --cycle)";
# "xdg-open $(fd --type file --hidden --follow --no-ignore --exclude .git --exclude node_modules | fzf)";
