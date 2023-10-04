__tmux() {
	local current_session
  local current_session_index

	current_session=$(tmux list-sessions | awk '/attached/ { print $1 }' | cut -d ':' -f 1)
  current_session_index=$(tmux list-sessions | awk '{print $1}' | grep -n "$current_session" | cut -d: -f1)
  # tmux display-popup -E "tmux list-panes -a -F '#{window_index} #{window_name}' | fzf | cut -c 1-1 | xargs tmux select-window -t"

	session=$(
		tmux ls 2>/dev/null | fzf \
			--reverse \
			--cycle \
			--jump-labels=3 \
			--height 50% \
			--delimiter=':' \
			--header-first \
			--header='<Enter> open  <C-k> kill  <C-Delete> kill all' \
			--bind='ctrl-k:reload-sync(tmux kill-session -t {1})' \
			--bind='ctrl-delete:execute(tmux kill-server)+abort' \
			--bind='enter:execute(echo {1})+abort' \
			--bind='tab:down,btab:up' \
			--bind='focus:execute-silent(tmux switch-client -t {1})' \
      --bind="load:pos($current_session_index)"
	)

	[ -z "$session" ] && return 1

	if [ -n "$TMUX" ]; then
		tmux switch-client -t "$session"
	else
		tmux attach-session -t "$session"
	fi
}

__new_session() {
	printf 'new session name : ' && read -r session

	[ -z "$session" ] && return 1

	if [ -n "$TMUX" ]; then
		tmux new-session -d -s "$session"
		tmux switch-client -t "$session"
	else
		tmux new-session -s "$session"
	fi
}
