# _select_files() {
#   files=$1
#
#   selected_files=$(echo "$files" | fzf \
#     --multi --inline-info --cycle --height 70% \
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
