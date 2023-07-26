#!/bin/sh

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
	ssh-agent -t 2h >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ -z "$SSH_AUTH_SOCK" ]; then
	. "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
