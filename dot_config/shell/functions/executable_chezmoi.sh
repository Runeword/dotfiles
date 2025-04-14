#!/bin/sh

__select_files() {
  echo "$1" | fzf \
    --multi --reverse --no-separator --border none --cycle --height 100% \
    --info=inline:'' \
    --header-first \
    --prompt='  ' \
    --scheme=path \
    --header="$2" \
    --bind='ctrl-a:select-all' \
    --preview 'chezmoi diff --reverse --color=true ~/{}' \
    --preview-window bottom,80%,noborder
}

__chezmoi() {
  local chezmoi_cmd="$1"
  local operation="$2"
  shift 2

  if ! $chezmoi_cmd "$operation" "$@" 2>/dev/null; then
    local files
    files=$($chezmoi_cmd status | awk '{print $2}')
    [ "$files" = "" ] && return 1

    local selected_files
    selected_files=$(__select_files "$files" "$chezmoi_cmd $operation")
    [ "$selected_files" = "" ] && return 1

    for i in $(echo "$selected_files" | xargs); do
      $chezmoi_cmd "$operation" "$@" "$HOME/$i"
    done
  fi
}

__chezmoi_public() {
  __chezmoi "chezmoi" "$@"
}

__chezmoi_private() {
  __chezmoi "chezmoi --source ~/.local/share/chezmoi-private --config ~/.config/chezmoi-private/chezmoi.toml" "$@"
}

__chezmoi_status() {
  local files
  files=$(chezmoi status | awk '{print $2}')
  [ "$files" = "" ] && return 1

  local selected_files
  selected_files=$(__select_files "$files")
  [ "$selected_files" = "" ] && return 1

  echo "$selected_files" | xargs "$EDITOR"
}

__chezmoi_cd() {
  cd "$(chezmoi source-path)" || exit
}

__chezmoi_managed() {
  local files
  files=$(chezmoi managed --include=files)
  [ "$files" = "" ] && return 1

  local selected_files
  selected_files=$(echo "$files" | fzf \
    --multi --reverse --no-separator --border none --cycle --height 70% \
    --info=inline:'' \
    --header-first \
    --prompt='  ' \
    --scheme=path \
    --header="chezmoi managed --include=files" \
    --bind='ctrl-a:select-all' \
    --preview 'bat --style=plain --color=always {}' \
    --preview-window right,70%,noborder)
  [ "$selected_files" = "" ] && return 1

  echo "$selected_files" | xargs "$EDITOR"
}

__chezmoi_forget() {
  if [ $# -gt 0 ]; then
    local selected_files
    selected_files=$*
  else
    local files
    files=$(chezmoi managed --include=files)
    [ "$files" = "" ] && return 1

    selected_files=$(echo "$files" | fzf \
      --multi --reverse --no-separator --border none --cycle --height 70% \
      --info=inline:'' \
      --header-first \
      --prompt='  ' \
      --scheme=path \
      --header="chezmoi forget" \
      --bind='ctrl-a:select-all' \
      --preview 'bat --style=plain --color=always {}' \
      --preview-window right,70%,noborder)
    [ "$selected_files" = "" ] && return 1
  fi

  # "$(echo "$selected_files" | xargs)" | while IFS= read -r i; do chezmoi forget "$HOME/$i"; done

  for i in $(echo "$selected_files" | xargs); do
    chezmoi forget "$HOME/$i"
  done
}
