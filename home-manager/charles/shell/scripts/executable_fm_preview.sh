#!/bin/sh

if [ -d "$1" ]; then
  if command -v exa >/dev/null; then
    exa -l "$1" --octal-permissions --color=always --total-size | sed 's/^/  /; 1s/^/\n/'
  else
    ls -l "$1"
  fi

  tree -Ca -L 2 "$1" | sed 's/^/ /; 1s/^/\n/'
else
  if command -v exa >/dev/null; then
    exa -l "$1" --octal-permissions --color=always | sed 's/^/  /; 1s/^/\n/'
  else
    ls -l "$1"
  fi

  if command -v bat >/dev/null; then
    bat --style=plain --color=always "$1" | sed 's/^/  /; 1s/^/\n/'
  else
    cat "$1"
  fi
fi
