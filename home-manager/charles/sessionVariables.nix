{ config
, pkgs
, lib
, ...
}: {
  home.sessionVariables = rec {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    BROWSER = "google-chrome-stable";

    # XDG Base Directory Specification
    XDG_CONFIG_DIRS = "/etc/xdg";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin";

    AWS_CONFIG_FILE = "${XDG_CONFIG_HOME}/aws/config";
    NOTMUCH_CONFIG = "${XDG_CONFIG_HOME}/notmuch/config";
    GNUPGHOME = "${XDG_CONFIG_HOME}/gnupg";

    PYENV_ROOT = "${XDG_DATA_HOME}/pyenv";
    PASSWORD_STORE_DIR = "${XDG_DATA_HOME}/password-store";

    # ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";

    # NPM_CONFIG_PREFIX = "${XDG_DATA_HOME}/npm";
    # TLDR_CACHE_DIR = "${XDG_CACHE_HOME}";

    # DIRENV_LOG_FORMAT = "$(tput setaf 0)direnv: %s$(tput sgr0)";
    # DIRENV_LOG_FORMAT = ''echo -e "\e[90mdirenv: %s\e[0m"'';

    FZF_DEFAULT_OPTS_FILE = "";

    FORGIT_FZF_DEFAULT_OPTS = "
  --exact \
  --reverse \
  --prompt='  ' \
  --no-separator \
  --info=inline:'' \
  --preview-window right,75%,border-none \
  ";

    FZF_DEFAULT_COMMAND = "
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

    FZF_DEFAULT_OPTS = "
--color=fg:#d0d0d0,bg:-1,hl:#918fcf \
--color=fg+:#ffffff,fg+:regular,bg+:#0e1c1c,hl+:#6bdbd8,hl+:regular,query:regular \
--color=info:#d0d0d0,prompt:#ffffff,pointer:#ff75a9,border:#2f394a \
--color=marker:#ff75a9,spinner:#ffffff,header:#535e73 \
";

    FZF_CTRL_R_OPTS = "
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
";

    FZF_CTRL_T_OPTS = "
--reverse \
--prompt='  ' \
--no-separator \
--info=inline:'' \
";

    # --color=fg+:#ffffff,fg+:regular,bg+:-1,hl+:#6bdbd8,hl+:regular,query:regular \
    # --color=fg+:#ffffff,fg+:regular,bg+:#262626,hl+:#6bdbd8,hl+:regular,query:regular \
  };
}
