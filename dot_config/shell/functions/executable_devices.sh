#!/bin/sh

__open_device() {
  local devices
  devices=$(ls /run/media/"$USER")

  if [ "$devices" = "" ]; then return 0; fi

  local device
  device=$(echo "$devices" | fzf \
    --reverse \
    --info=hidden \
    --prompt='  ' \
    --no-separator \
    --height 70% \
    --header="C-u unmount device" \
    --header-first \
    --bind='ctrl-u:reload-sync(umount /run/media/"$USER"/{})'
  )

  if [ "$device" = "" ]; then return 0; fi

  cd "/run/media/$USER/$device" || return 0
}
