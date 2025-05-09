#!/bin/sh

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"
export BROWSER="google-chrome-stable"

# DIRENV_LOG_FORMAT = "$(tput setaf 0)direnv: %s$(tput sgr0)";
# DIRENV_LOG_FORMAT = ''echo -e "\e[90mdirenv: %s\e[0m"'';

# _____________________________________________ FZF

export FZF_DEFAULT_OPTS_FILE=""
export FORGIT_FZF_DEFAULT_OPTS="
--exact \
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
--preview-window right,75%,border-none \
--bind='ctrl-a:select-all' \
"
# export FZF_DEFAULT_COMMAND="
# fd \
# --reverse \
# --prompt='  ' \
# --no-separator \
# --info=inline:'' \
# --hidden \
# --follow \
# --no-ignore \
# --exclude .git \
# --exclude node_modules \
# ";

# --color=marker:#57b58f,spinner:#ffffff,header:#535e73 \
export FZF_DEFAULT_OPTS="
--color=fg:#d0d0d0,bg:-1,hl:#ffffff,gutter:-1 \
--color=fg+:#ffffff,fg+:regular,bg+:#142920,hl+:#67d6a9,hl+:regular,query:italic \
--color=info:#d0d0d0,prompt:#ffffff,pointer:#67d6a9,border:#2f394a \
--color=marker:#458f71,spinner:#ffffff,header:#535e73 \
"

export FZF_CTRL_R_OPTS="
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
"
export FZF_CTRL_T_OPTS="
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
"

# --color=fg+:#ffffff,fg+:regular,bg+:-1,hl+:#6bdbd8,hl+:regular,query:regular \
# --color=fg+:#ffffff,fg+:regular,bg+:#262626,hl+:#6bdbd8,hl+:regular,query:regular \
