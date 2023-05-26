set -g fish_greeting

bind \cu kill-whole-line
bind \cj backward-kill-line
bind \ck kill-line
bind \cH backward-kill-word
bind \e\[3\;5~ kill-word
bind \e\[A history-prefix-search-backward
bind \e\[E history-prefix-search-forward

bind \cn 'nvim'
bind \cb 'br -c :open_preview'
