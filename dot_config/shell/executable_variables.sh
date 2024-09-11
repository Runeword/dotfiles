export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_BIN_HOME="${HOME}/.local/bin"

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"
export BROWSER="google-chrome-stable"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch/config"
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export ATAC_KEY_BINDINGS="${XDG_CONFIG_HOME}/atac/vim_key_bindings.toml"
export ATAC_THEME="${XDG_CONFIG_HOME}/atac/theme.toml"
export NIXOS_CONFIG="${XDG_CONFIG_HOME}/nixos/configuration.nix"
# ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";
# NPM_CONFIG_PREFIX = "${XDG_DATA_HOME}/npm";
# TLDR_CACHE_DIR = "${XDG_CACHE_HOME}";
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
";
export FZF_DEFAULT_COMMAND="
fd \
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
--hidden \
--follow \
--no-ignore \
--exclude .git \
--exclude node_modules \
";
export FZF_DEFAULT_OPTS="
--color=fg:#d0d0d0,bg:-1,hl:#918fcf \
--color=fg+:#ffffff,fg+:regular,bg+:#0e1c1c,hl+:#6bdbd8,hl+:regular,query:regular \
--color=info:#d0d0d0,prompt:#ffffff,pointer:#ff75a9,border:#2f394a \
--color=marker:#ff75a9,spinner:#ffffff,header:#535e73 \
";
export FZF_CTRL_R_OPTS="
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
";
export FZF_CTRL_T_OPTS="
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
";

# --color=fg+:#ffffff,fg+:regular,bg+:-1,hl+:#6bdbd8,hl+:regular,query:regular \
# --color=fg+:#ffffff,fg+:regular,bg+:#262626,hl+:#6bdbd8,hl+:regular,query:regular \
