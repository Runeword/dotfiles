#!/bin/sh

if [ -d "$1" ]; then
  tree -Ca -L 2 "$1" | sed 's/^/  /; 1s/^/\n/'
else
  if command -v bat >/dev/null; then
    bat --style=plain --color=always "$1" | sed 's/^/  /; 1s/^/\n/'
  else
    cat "$1"
  fi
fi
