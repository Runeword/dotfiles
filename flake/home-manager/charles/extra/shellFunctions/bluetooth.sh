#!/bin/sh

b () {
choice1=$(bluetoothctl devices | fzf \
--preview 'bluetoothctl info {2} | head -$FZF_PREVIEW_LINES' \
--preview-window right,65%,noborder \
--no-scrollbar \
--header-first \
--header='FILTER   <C-a> all       <C-p> paired
         <C-c> connected <C-t> trusted
SCAN     <C-s>' \
--bind='enter:execute(echo {2})+abort' \
--bind='ctrl-s:execute-silent(bluetoothctl scan on&)' \
--bind='ctrl-a:reload-sync(bluetoothctl devices)' \
--bind='ctrl-p:reload-sync(bluetoothctl devices Paired)' \
--bind='ctrl-c:reload-sync(bluetoothctl devices Connected)' \
--bind='ctrl-t:reload-sync(bluetoothctl devices Trusted)'
);

[ -n "$choice1" ] || return 0

choice2=$(echo -e "connect\ndisconnect\npair\nremove\ntrust\nuntrust" | fzf \
--preview "bluetoothctl info $choice1 | head -$FZF_PREVIEW_LINES" \
--preview-window right,65%,noborder \
--no-scrollbar \
--bind="enter:preview:[ -n "{1}" ] && [ -n "$choice1" ] && bluetoothctl {1} $choice1"
);

b
}
