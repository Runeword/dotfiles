#!/bin/sh

__open_file() {
  # Select file(s) with fzf, if no selection do nothing

  local selected_files
  selected_files=$(
    find -L . \
      \( -name '.git' \
      -o -name 'flake-inputs' \
      -o -name '.nix-defexpr' \
      -o -name '.nix-profile' \
      -o -path './.config/figma-linux/Cache' \
      -o -path './.config/Slack/Cache' \
      -o -path './.config/Slack/Service Worker' \
      -o -path './.config/google-chrome' \
      -o -path './.local/share/navi/cheats' \
      -o -path './.local/share/containers/storage/overlay' \
      -o -path './go/pkg' \
      -o -name '.cache' \
      -o -name '.tldrc' \
      -o -name 'node_modules' \
      -o -path './.local' \
      -o -name '.direnv' \) \
      -prune -o -printf '%P\n' 2>/dev/null |
      tail -n +2 |
      fzf \
        --height 70% \
        --border none \
        --prompt='  ' \
        --multi \
        --reverse \
        --info=hidden \
        --no-separator \
        --cycle \
        --ansi \
        --header-first \
        --header=''\''exact !not [!]^prefix [!]suffix$' \
        --preview "$HOME/.config/shell/scripts/fm_preview.sh {}" \
        --preview-window right,55%,border-none,~3 \
        --bind='ctrl-y:execute-silent(wl-copy {})' \
        --sync \
  ) || return 0
  # fzf-tmux \
  #   -p \
  #   -h 90% \
  #   -w 95% \

  # Check number of selected files
  local num_lines
  num_lines="$(echo "$selected_files" | wc -l)"

  # cd into selected directory
  if [ "$num_lines" -eq 1 ] && [ -d "$selected_files" ]; then
    if ! cd "$selected_files"; then
      echo "Fail: could not change directory to $selected_files"
      return 1
    fi

    # Then write command in history
    [ "$BASH_VERSION" != "" ] && history -s "cd $selected_files"
    [ "$ZSH_VERSION" != "" ] && print -s "cd $selected_files"
  else
    # else open selected files in editor
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
      --prompt='  ' \
      --cycle \
      --info=hidden \
      --height 70% \
      --no-separator \
      --header-first \
      --header=''\''exact !not [!]^prefix [!]suffix$' \
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
# --info=inline:'' \
