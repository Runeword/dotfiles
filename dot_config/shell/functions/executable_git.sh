#!/bin/sh

__git_clone() {
  local repo_url="${1:-$(wl-paste)}" # Use clipboard content if no URL is provided
  local base_dir="${HOME}/{$1}"
  mkdir -p "$base_dir" # Create the base directory if it doesn't exist
  git clone "$repo_url" "$base_dir/$(basename "$repo_url" .git)";
  cd "$base_dir/$(basename "$repo_url" .git)" || return # Change into the cloned directory
}
