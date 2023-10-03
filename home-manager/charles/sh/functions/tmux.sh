__tmux() {
	session=$(
		tmux ls | fzf \
			--reverse \
			--height 50% \
			--delimiter=':' \
			--header-first \
			--header='<CR> attach  <C-k> kill  <C-a> kill all' \
			--bind='ctrl-k:reload-sync(tmux kill-session -t {1})' \
			--bind='ctrl-q:execute(tmux kill-server)+abort' \
			--bind='enter:execute(echo {1})+abort' \
      --bind='tab:down,btab:up'
	)

	[ -z "$session" ] && return 1

	if ! tmux attach-session -t "$session"; then
		tmux switch-client -t "$session"
	fi
}
