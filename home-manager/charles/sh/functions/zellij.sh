__zellij() {
	session=$(
		zellij list-sessions 2>/dev/null | fzf \
			--reverse \
			--header-first \
      --height 50% \
			--header='<CR> attach  <C-k> kill  <C-a> kill all' \
			--bind='ctrl-k:reload-sync(zellij kill-session {1})' \
			--bind='ctrl-a:reload-sync(zellij kill-all-sessions --yes)'
	)

	[ -z "$session" ] && return 1

	zellij attach "$session"
}
