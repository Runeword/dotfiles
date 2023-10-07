__tmux() {
	if [ -z "$(tmux list-sessions 2>/dev/null)" ]; then
		trap 'return' INT
		printf 'new session name : ' && read -r input

		tmux new-session ${input:+-s"$input"}

		return 1
	fi

	local item_pos
  local session_id

  session_id=$(tmux display-message -p '#{session_id}')
  item_pos=$(tmux list-sessions -F '#{session_id}' | awk '{if ($1 == "'$session_id'") print NR}')

	# tmux display-popup -E "tmux list-panes -a -F '#{window_index} #{window_name}' | fzf | cut -c 1-1 | xargs tmux select-window -t"
	# ${TMUX:+--no-header} \

	session=$(
		tmux ls -F "#{session_name}" 2>/dev/null | fzf \
			--reverse \
			--cycle \
			--jump-labels=3 \
			--height 50% \
			--delimiter=' ' \
			--header-first \
			--header='<C-k> kill  <C-Del> kill all' \
			--bind='ctrl-k:reload-sync(tmux kill-session -t {1})' \
			--bind='ctrl-delete:execute(tmux kill-server)+abort' \
			--bind='enter:execute(echo {1})+abort' \
			--bind='tab:down,btab:up' \
			${TMUX:+--bind='focus:execute-silent(tmux switch-client -t {1})'} \
			${TMUX:+--bind="load:pos($item_pos)"}
	)

	[ -z "$session" ] && return 1

	if [ -n "$TMUX" ]; then
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
tmux list-windows -a -F '#{window_name} #{session_name} #{window_id} #{session_id}' 2>/dev/null | fzf \
    --reverse \
    --cycle \
    --jump-labels=3 \
    --height 50% \
    --delimiter=' ' \
    --header-first \
    --bind='tab:down,btab:up' \
    ${TMUX:+--bind='focus:execute-silent(tmux switch-client -t {4}; tmux select-window -t {3})'} \
    ${TMUX:+--bind="load:pos($item_pos)"}
)

# [ -z "$session" ] && return 1
#
# if [ -n "$TMUX" ]; then
#   tmux switch-client -t "$session"
# else
#   tmux attach-session -t "$session"
# fi
}

__new_session() {
	trap 'return' INT
	printf 'new session name : ' && read -r input

	session=$(tmux new-session -d ${input:+-s"$input"} -P -F "#{session_name}")

	if [ -n "$TMUX" ]; then
		tmux switch-client -t "$session"
	else
		tmux attach-session -t "$session"
	fi
}
