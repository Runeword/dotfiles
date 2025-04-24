#!/bin/sh
set -e

find_up() {
  current_dir="$PWD"
  flake_file="flake.nix"

  while true; do
    if [ -f "$current_dir/$flake_file" ]; then
      echo "$current_dir"
      exit 0
    fi

    if [ "$current_dir" = "/" ]; then
      echo "ERROR: Unable to locate flake.nix in any parent directory" >&2
      exit 1
    fi

    current_dir="$(dirname "$current_dir")"
  done
}

find_up
