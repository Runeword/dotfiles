#!/bin/sh

pc() {
  local files
  files=$(pass git ls-files | sed -e '/^\./d' -e 's/\.gpg$//')
  [ "$files" = "" ] && return 1

  selected_file=$(echo "$files" | fzf \
    --reverse --no-separator --border none --cycle --height 70% \
    --info=inline:'' \
    --header-first \
    --prompt='  ' \
    --header='pass --clip' \
    --preview '[ -f {} ] && bat --style=plain --color=always {}' \
    --preview-window right,70%,noborder) || return 0

  pass --clip "$selected_file"
}

pd() {
  local files
  files=$(pass git ls-files | sed -e '/^\./d' -e 's/\.gpg$//')
  [ "$files" = "" ] && return 1

  selected_files=$(echo "$files" | fzf \
    --multi --reverse --no-separator --border none --cycle --height 70% \
    --info=inline:'' \
    --header-first \
    --prompt='  ' \
    --header='pass rm' \
    --preview '[ -f {} ] && bat --style=plain --color=always {}' \
    --preview-window right,70%,noborder) || return 0

  for i in $(echo "$selected_files" | xargs); do
    pass rm "$i"
  done
}
