#!/bin/sh

__select_files() {
  echo "$1" | fzf \
    --multi --reverse --no-separator --border none --cycle --height 100% \
    --info=inline:'' \
    --header-first \
    --header="$2" \
    --preview 'chezmoi diff --reverse --color=true ~/{}' \
    --preview-window bottom,80%,noborder
}

cha() {
  if [ $# -gt 0 ]; then
    local selected_files
    selected_files=$*
  else
    local files
    files=$(chezmoi status | awk '{print $2}')
    [ "$files" = "" ] && return 1

    selected_files=$(__select_files "$files" "chezmoi add")
    [ "$selected_files" = "" ] && return 1
  fi

  # "$(echo "$selected_files" | xargs)" | while IFS= read -r i; do chezmoi add "$HOME/$i"; done

  for i in $(echo "$selected_files" | xargs); do
    chezmoi add "$HOME/$i"
  done
}

chy() {
  if [ $# -gt 0 ]; then
    local selected_files
    selected_files=$*
  else
    local files
    files=$(chezmoi status | awk '{print $2}')
    [ "$files" = "" ] && return 1

    selected_files=$(__select_files "$files", "chezmoi apply")
    [ "$selected_files" = "" ] && return 1
  fi

  # "$(echo "$selected_files" | xargs)" | while IFS= read -r i; do chezmoi apply "$HOME/$i"; done

  for i in $(echo "$selected_files" | xargs); do
    chezmoi apply "$HOME/$i"
  done
}

ch() {
  local files
  files=$(chezmoi status | awk '{print $2}')
  [ "$files" = "" ] && return 1

  local selected_files
  selected_files=$(__select_files "$files")
  [ "$selected_files" = "" ] && return 1

  echo "$selected_files" | xargs "$EDITOR"
}

chf() {
  if [ $# -gt 0 ]; then
    local selected_files
    selected_files=$*
  else
    local files
    files=$(chezmoi managed)
    [ "$files" = "" ] && return 1

    selected_files=$(echo "$files" | fzf \
      --multi --reverse --no-separator --border none --cycle --height 70% \
      --info=inline:'' \
      --header-first \
      --header="chezmoi forget" \
      --preview '[ -f {} ] && bat --style=plain --color=always {}' \
      --preview-window right,70%,noborder)
    [ "$selected_files" = "" ] && return 1
  fi

  # "$(echo "$selected_files" | xargs)" | while IFS= read -r i; do chezmoi forget "$HOME/$i"; done

  for i in $(echo "$selected_files" | xargs); do
    chezmoi forget "$HOME/$i"
  done
}
