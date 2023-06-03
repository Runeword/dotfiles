#!/bin/sh

__bluetooth() {
	bluetoothctl devices | fzf \
		--preview 'bluetoothctl info {2} | head -$FZF_PREVIEW_LINES' \
		--preview-window right,65%,noborder \
		--no-scrollbar \
		--header-first \
		--header='
C-s  scan devices 
C-w  bluetoothctl power on/off
C-b  bluetooth on/off

< DEVICE >         < LIST >
C-p  pair          A-p  paired
C-c  connect       A-c  connected
C-t  trust         A-t  trusted
C-d  disconnect    A-a  all
C-r  remove
C-u  untrust
' \
		--bind='enter:execute-silent(echo {2} | xclip -selection clipboard)' \
		--bind='ctrl-s:execute-silent(bluetoothctl scan on&)' \
		--bind='ctrl-p:preview:bluetoothctl pair {2}' \
		--bind='ctrl-r:preview:bluetoothctl remove {2}' \
		--bind='ctrl-t:preview:bluetoothctl trust {2}' \
		--bind='ctrl-u:preview:bluetoothctl untrust {2}' \
		--bind='ctrl-c:preview:bluetoothctl connect {2}' \
		--bind='ctrl-d:preview:bluetoothctl disconnect {2}' \
		--bind='ctrl-w:preview:bluetoothctl show | grep -q "Powered: yes" && bluetoothctl power off || bluetoothctl power on' \
		--bind='ctrl-b:preview:bluetooth | grep -q "bluetooth = on" && bluetooth off || bluetooth on' \
		--bind='alt-a:reload-sync(bluetoothctl devices)' \
		--bind='alt-p:reload-sync(bluetoothctl devices Paired)' \
		--bind='alt-c:reload-sync(bluetoothctl devices Connected)' \
		--bind='alt-t:reload-sync(bluetoothctl devices Trusted)'
}
# --bind='enter:execute(echo {2})+abort' \
