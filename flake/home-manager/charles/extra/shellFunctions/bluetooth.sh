#!/bin/sh

b () {
bluetoothctl devices | fzf \
--preview 'bluetoothctl info {2} | head -$FZF_PREVIEW_LINES' \
--preview-window right,65%,noborder \
--no-scrollbar \
--header-first \
--header='
ACTION           FILTER
C-s  scan        A-a  all
C-p  pair        A-p  paired
C-c  connect     A-c  connected
C-t  trust       A-t  trusted
C-d  disconnect
C-r  remove
C-u  untrust
C-o  on/off
' \
--bind='enter:execute(echo {2})+abort' \
--bind='ctrl-s:execute-silent(bluetoothctl scan on&)' \
--bind='ctrl-p:preview:bluetoothctl pair {2}' \
--bind='ctrl-r:preview:bluetoothctl remove {2}' \
--bind='ctrl-t:preview:bluetoothctl trust {2}' \
--bind='ctrl-u:preview:bluetoothctl untrust {2}' \
--bind='ctrl-c:preview:bluetoothctl connect {2}' \
--bind='ctrl-d:preview:bluetoothctl disconnect {2}' \
--bind='ctrl-o:preview:bluetooth | grep -q "bluetooth = on" && bluetooth off || bluetooth on' \
--bind='alt-a:reload-sync(bluetoothctl devices)' \
--bind='alt-p:reload-sync(bluetoothctl devices Paired)' \
--bind='alt-c:reload-sync(bluetoothctl devices Connected)' \
--bind='alt-t:reload-sync(bluetoothctl devices Trusted)'
}
