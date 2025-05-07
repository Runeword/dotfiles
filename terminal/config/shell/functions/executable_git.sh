#!/bin/sh

__git_clone() {
  local repo_url="${2:-$(wl-paste)}" # Use clipboard content if no URL is provided
  local base_dir="${HOME}/${1}"
  mkdir -p "$base_dir" # Create the base directory if it doesn't exist
  git clone "$repo_url" "$base_dir/$(basename "$repo_url" .git)"
  cd "$base_dir/$(basename "$repo_url" .git)" || return # Change into the cloned directory
}

__git_open_all() {
  local repo_root
  repo_root="$(git rev-parse --show-toplevel)"
  {
    git diff --name-only                     # unstaged
    git diff --name-only --cached            # staged
    git ls-files --others --exclude-standard # untracked
  } | sort -u |
    fzf \
      --multi --reverse --no-separator --border none --cycle --height 70% \
      --info=inline:'' \
      --header-first \
      --prompt='  ' \
      --scheme=path \
      --bind='ctrl-a:select-all' |
    sed "s|^|$repo_root/|" |
    xargs -r nvim
}

__git_open_unstaged() {
  local repo_root
  repo_root="$(git rev-parse --show-toplevel)"
  git ls-files --others --exclude-standard --modified |
    fzf \
      --multi --reverse --no-separator --border none --cycle --height 70% \
      --info=inline:'' \
      --header-first \
      --prompt='  ' \
      --scheme=path \
      --bind='ctrl-a:select-all' |
    sed "s|^|$repo_root/|" |
    xargs -r nvim
}

__git_open_staged() {
  local repo_root
  repo_root="$(git rev-parse --show-toplevel)"
  git diff --name-only --cached |
    fzf \
      --multi --reverse --no-separator --border none --cycle --height 70% \
      --info=inline:'' \
      --header-first \
      --prompt='  ' \
      --scheme=path \
      --bind='ctrl-a:select-all' |
    sed "s|^|$repo_root/|" |
    xargs -r nvim
}
