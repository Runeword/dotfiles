#!/bin/sh

__kill_processes() {
  local pid
  pid=$(
    ps -ef |
      fzf -m \
        --height 70% \
        --border none \
        --prompt='  ' \
        --multi \
        --reverse \
        --info=hidden \
        --no-separator \
        --header-lines=1 \
        --cycle |
      awk '{print $2}'
  )

  if [ -z "$pid" ]; then
    return 1
  fi

  echo "$pid" | xargs kill -9 && echo "$pid"
}
