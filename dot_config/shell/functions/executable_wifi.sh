#!/bin/sh

__nmcli_connection_delete() {
  nmcli -f UUID,NAME,TYPE connection show | grep wifi |
    fzf \
      --reverse \
      --prompt='  ' \
      --no-separator \
      --info=inline:'' \
      --no-scrollbar \
      --header-first \
      --header='nmcli connection delete' |
    awk '{print $1}' | xargs -n1 nmcli connection delete
}

__nmcli_connection_up() {
  nmcli -f UUID,NAME,TYPE connection show | grep wifi |
    fzf \
      --reverse \
      --prompt='  ' \
      --no-separator \
      --info=inline:'' \
      --no-scrollbar \
      --header-first \
      --header='nmcli connection up' |
    awk '{print $1}' | xargs -n1 nmcli connection up
}

__nmcli_connection_down() {
  nmcli -f UUID,NAME,TYPE connection show --active | grep wifi | awk '{print $1}' | xargs -n1 nmcli connection down
}

__nmcli_wifi_toggle() {
  if [ "$(nmcli radio wifi)" = enabled ]; then
    nmcli radio wifi off
  else
    nmcli radio wifi on
  fi
  echo "wifi $(nmcli radio wifi)"
}

__nmcli_wifi_connect() {
  nmcli device wifi connect "$(nmcli -f IN-USE,BSSID,SSID,MODE,CHAN,RATE,SIGNAL,BARS,SECURITY device wifi | fzf \
    --header-lines=1 \
    --reverse \
    --prompt='  ' \
    --no-separator \
    --info=inline:'' \
    --no-scrollbar \
    --header-first \
    --header='nmcli device wifi connect' |
    awk '{print $2}')" --ask
}

# __nmcli() {
#   local ssid

#   ssid=$(
#     nmcli device wifi 2>/dev/null | fzf \
#       --header-lines=1 \
#       --preview 'echo {2}' \
#       --preview-window right,30%,noborder \
#       --reverse \
#       --prompt='  ' \
#       --no-separator \
#       --info=inline:'' \
#       --no-scrollbar \
#       --header-first \
#       --header='
# C-c    connect          C-r    rescan
# C-d    disconnect       C-o    wifi on/off
# C-DEL  delete
# ' \
#       --bind='enter:execute(echo {2})+abort' \
#       --bind='ctrl-c:execute-silent(nmcli connection up {2})+reload(nmcli device wifi)' \
#       --bind='ctrl-d:execute-silent(nmcli connection down {3})+reload(nmcli device wifi)' \
#       --bind='ctrl-delete:execute-silent(nmcli connection delete {2})+reload(nmcli device wifi)' \
#       --bind="ctrl-o:execute-silent(if [ $(nmcli radio wifi) = enabled ]; then nmcli radio wifi off; else nmcli radio wifi on; fi)+reload-sync(nmcli device wifi)" \
#       --bind='ctrl-r:execute-silent(nmcli device wifi rescan)+reload-sync(nmcli device wifi)'
#   ) || return 0

#   nmcli device wifi connect "$ssid" --ask
# }
