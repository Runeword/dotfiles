#!/usr/bin/sh

__switch_session() {
  if [ "$(tmux list-sessions 2>/dev/null)" = "" ]; then
		trap 'return' INT
		printf 'new session name : ' && read -r input

		tmux new-session ${input:+-s"$input"}

		return 1
	fi

  local session_id
  session_id=$(tmux display-message -p '#{session_id}')

  local item_pos
  item_pos=$(tmux list-sessions -F '#{session_id}' | awk '{if ($1 == "'"$session_id"'") print NR}')

# --delimiter=' ' \
	local session
	session=$(
		tmux ls -F "#{session_name}" 2>/dev/null | fzf \
			--reverse \
			--cycle \
			--height 50% \
      --no-separator \
      --prompt='  ' \
      --reverse \
      --info=inline:'' \
			--bind='tab:down,btab:up' \
      --bind='enter:execute(echo {1})+abort' \
			${TMUX:+--bind='focus:execute-silent(tmux switch-client -t {1})'} \
			${TMUX:+--bind="load:pos($item_pos)"}
	)

  [ "$session" = "" ] && return 1

  if [ "$TMUX" != "" ]; then
    tmux switch-client -t "$session"
  else
    tmux attach-session -t "$session"
  fi
}

__switch_window() {
	local item_pos
	local window_id
	local window

	window_id=$(tmux display-message -p '#{window_id}')
	item_pos=$(tmux list-windows -a -F '#{window_id}' | awk '{if ($1 == "'$window_id'") print NR}')

	window=$(
		tmux list-windows -a -F '#{session_name}#{window_name} #{window_id} #{session_id}' 2>/dev/null | fzf \
		  --with-nth='1,2' \
			--reverse \
			--cycle \
			--height 50% \
			--delimiter=' ' \
      --prompt='  ' \
      --reverse \
      --no-separator \
      --info=inline:'' \
			--bind='tab:down,btab:up' \
			${TMUX:+--bind='focus:execute-silent(tmux switch-client -t {4}; tmux select-window -t {3})'} \
			${TMUX:+--bind="load:pos($item_pos)"}
	)
}

__new_session() {
	trap 'return' INT
	printf 'new session : ' && read -r input

	session=$(tmux new-session -d ${input:+-s"$input"} -P -F "#{session_name}")

	if [ -n "$TMUX" ]; then
		tmux switch-client -t "$session"
	else
		tmux attach-session -t "$session"
	fi
}

__kill_session() {
  tmux switch-client -n
  tmux kill-session -t "$(tmux display-message -p "#S")" || tmux kill-session
}

__attach_unattached_session() {
  local unattached_session
  unattached_session=$(tmux ls -F '#{session_name}|#{?session_attached,attached,not attached}' 2>/dev/null | awk -F'|' '/not attached/ {print $1}' | head -1) 2>/dev/null

  if [ "$unattached_session" != "" ]; then
    tmux attach -t "$unattached_session"
  else
    tmux
  fi
}
