#!/bin/sh

__nmcli() {
  local ssid

  ssid=$(
    nmcli device wifi 2>/dev/null | fzf \
      --header-lines=1 \
      --preview 'echo {2}' \
      --preview-window right,30%,noborder \
      --no-scrollbar \
      --header-first \
      --header='C-ENT  connect     C-r    rescan
C-u    up          C-o    wifi on/off
C-d    down
C-DEL  delete' \
      --bind='enter:execute(echo {2})+abort' \
      --bind='ctrl-c:execute-silent(nmcli connection up {2})+reload(nmcli device wifi)' \
      --bind='ctrl-d:execute-silent(nmcli connection down {3})+reload(nmcli device wifi)' \
      --bind='ctrl-delete:execute-silent(nmcli connection delete {2})+reload(nmcli device wifi)' \
      --bind="ctrl-o:execute-silent(if [ $(nmcli radio wifi) = enabled ]; then nmcli radio wifi off; else nmcli radio wifi on; fi)+reload-sync(nmcli device wifi)" \
      --bind='ctrl-r:execute-silent(nmcli device wifi rescan)+reload-sync(nmcli device wifi)'
  ) || return 0

  nmcli device wifi connect "$ssid"
}
