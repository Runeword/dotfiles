#!/bin/sh

__distrobox_enter() {
  distrobox list | fzf \
    --header-lines=1 \
    --reverse \
    --prompt='  ' \
    --no-separator \
    --info=inline:'' \
    --no-scrollbar \
    --header-first \
    --header='distrobox enter'
}
