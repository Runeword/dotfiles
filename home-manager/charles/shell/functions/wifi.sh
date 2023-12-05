__wifi() {
  local ssid

  # nmcli device wifi rescan > /dev/null

  ssid=$(
    nmcli device wifi | fzf \
      --header-lines=1 \
      --preview 'echo {2}' \
      --preview-window right,45%,noborder \
      --no-scrollbar \
      --header-first \
      --header='
      C-u    up
      C-d    down
      C-del  delete 
      C-r    reload
      ' \
      --bind='enter:execute-silent(nmcli --ask device wifi connect {2})' \
      --bind='ctrl-u:execute-silent(nmcli connection up {2})+reload(nmcli device wifi)' \
      --bind='ctrl-d:execute-silent(nmcli connection down {3})+reload(nmcli device wifi)' \
      --bind='ctrl-delete:execute-silent(nmcli connection delete {2})+reload(nmcli device wifi)' \
      --bind='ctrl-r:reload(nmcli device wifi)'
  )

  # nmcli --ask device wifi connect "$ssid"
}
