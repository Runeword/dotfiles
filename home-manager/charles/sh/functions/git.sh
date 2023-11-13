# _select_files() {
#   files=$1
#
#   selected_files=$(echo "$files" | fzf \
#     --multi --info=inline:'' --cycle --height 70% \
#     --preview 'git diff --color=always {}' \
#     --preview-window bottom,80%,noborder
#   )
#
#   echo "$selected_files"
# }
#
# ga() {
#   # Change to the root of the git repository
#   # cd "$(git rev-parse --show-toplevel)"
#
#   files=$(git status --porcelain | awk '{print $2}')
#   [ -z "$files" ] && return 1
#
#   selected_files=$($_select_files "$files")
#   [ -z "$selected_files" ] && return 1
#
#   git add "$selected_files"
# }

# __sel_files() {
#   echo "$1" | fzf \
#     --multi --reverse --no-separator --border none --cycle --height 100% \
#     --info=inline:'' \
#     --header-first \
#     --header='git diff' \
#     --preview 'git diff --color=always {}' \
#     --preview-window bottom,80%,noborder
# }
#
# gd() {
#   [ $# -gt 0 ] && git diff "$@" && return 0
#
#   local files
#   files=$(git status -s | awk '{print $2}')
#   [ "$files" = "" ] && return 0
#
#   local selected_files
#   selected_files=$(__sel_files "$files")
#   [ "$selected_files" = "" ] && return 0
#
#   echo "$selected_files" | xargs "$EDITOR"
# }
