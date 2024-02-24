#!/bin/sh

__run_alias() {
  eval "$(
    alias | fzf \
      --delimiter='=' \
      --height 70% \
      --reverse \
      --prompt='  ' \
      --no-separator \
      --info=inline:'' \
      --bind "enter:execute(echo {2} | tr -d \"'\")+abort"
  )"
}
