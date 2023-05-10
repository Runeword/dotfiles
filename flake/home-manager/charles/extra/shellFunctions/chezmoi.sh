cha() {
  files=$(chezmoi status | awk '{print $2}')
  [ -z "$files" ] && return 1

  selected_files=$(echo "$files" | fzf \
    --multi --inline-info --cycle --height 70% \
    --preview 'chezmoi diff --reverse --color=true ~/{}' \
    --preview-window bottom,80%,noborder
  )
  [ -z "$selected_files" ] && return 1

  chezmoi add $selected_files
}
