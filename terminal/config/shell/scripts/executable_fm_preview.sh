#!/bin/sh

if [ -d "$1" ]; then
  # if command -v exa >/dev/null; then
  #   exa "$1" --long --octal-permissions --color=always --list-dirs --total-size |
  #     sed 's/^/  /; 1s/^/\n/'
  # else
  #   ls -ld "$1"
  # fi

  # tree -Ca -L 2 "$1" | sed 's/^/  /; 1s/^/\n/'
  command ls -C --almost-all --color --width 90 "$1"
else
  # if command -v exa >/dev/null; then
  #   exa "$1" --long --octal-permissions --color=always |
  #     sed 's/^/  /; 1s/^/\n/'
  # else
  #   ls -l "$1"
  # fi

  if command -v bat >/dev/null; then
    bat --style=plain --color=always "$1" |
      sed 's/^/  /; 1s/^/\n/'
  else
    cat "$1"
  fi
fi
