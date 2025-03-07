#!/bin/sh

__leader_widget() {
  local leader_exit leader_next
  leader_next=$(SHELL=/bin/zsh BUFFER=$BUFFER CURSOR=$CURSOR leader print)
  leader_exit=$?
  zle reset-prompt
  if [ $leader_exit -eq 3 ]; then
      BUFFER="${BUFFER}${KEYS}"
      CURSOR=$((CURSOR + $#KEYS))
      return "$leader_exit"
  fi
  eval "$leader_next"
}
