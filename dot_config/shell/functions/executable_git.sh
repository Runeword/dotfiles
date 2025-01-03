#!/bin/sh

__git_clone() {
  local repo_url="${2:-$(wl-paste)}" # Use clipboard content if no URL is provided
  local base_dir="${HOME}/${1}"
  mkdir -p "$base_dir" # Create the base directory if it doesn't exist
  git clone "$repo_url" "$base_dir/$(basename "$repo_url" .git)";
  cd "$base_dir/$(basename "$repo_url" .git)" || return # Change into the cloned directory
}

__git_aliases() {
  local selected_command
  selected_command=$(< ~/.config/navi/git-aliases \
    column \
    --table \
    --separator $'\t' \
    --output-separator $'\u00A0' \
    | fzf -i \
    --with-nth=1,2,3 \
    --print-query \
    --query "^" \
    --exact \
    --nth=1 \
    --no-info \
    --no-separator \
    --delimiter=$'\u00A0' \
    --cycle \
    --no-preview \
    --reverse \
    --prompt='  ' \
    --bind 'one:accept,zero:accept,tab:accept' \
    --height 70% \
  )

  if [ $? -eq 0 ]; then
    LBUFFER+=$(echo "$selected_command" | awk -F $'\u00A0' '{ if (NR==2) { sub(/[[:space:]]+$/, "", $2); print $2 " " } }')
  elif [ "$selected_command" ]; then
    LBUFFER+=g$(echo "$selected_command" | sed -n '1p' | sed 's/[^[:alpha:]]//g')
  fi

  return 1
}
