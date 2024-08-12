#!/bin/sh

__run_alias() {
  local selected

  selected=$(alias \
    | fzf \
      --delimiter='=' \
      --height 70% \
      --reverse \
      --prompt='  ' \
      --no-separator \
      --info=inline:'' \
    | awk -F'=' '{print $2}' | sed "s/^'//;s/'$//") || return 0

    eval "$selected"
}
