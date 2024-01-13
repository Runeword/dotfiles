{
  config,
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";
  home.sessionVariables.MANPAGER = "nvim +Man!";
  home.sessionVariables.DIRENV_LOG_FORMAT = "$(tput setaf 0)direnv: %s$(tput sgr0)";
  # home.sessionVariables.GRIMBLAST_EDITOR = "swappy";

  home.sessionVariables.FORGIT_FZF_DEFAULT_OPTS = "
--preview-window border-none \
";

#   home.sessionVariables._ZO_FZF_OPTS = "
# --reverse \
# --height 40% \
# --no-separator \
# --border none \
# ";

  home.sessionVariables.FZF_DEFAULT_COMMAND = "
fd \
--hidden \
--follow \
--no-ignore \
--exclude .git \
--exclude node_modules \
";

  home.sessionVariables.FZF_DEFAULT_OPTS = "
--reverse \
--no-separator \
--info=inline:'' \
--border none \
--color=fg:#d0d0d0,bg:-1,hl:#918fcf \
--color=fg+:#ffffff,fg+:regular,bg+:#0e1c1c,hl+:#6bdbd8,hl+:regular,query:regular \
--color=info:#d0d0d0,prompt:#ffffff,pointer:#ff75a9 \
--color=marker:#ff75a9,spinner:#ffffff,header:#535e73 \
--prompt='  ' \
";
  # --color=fg+:#ffffff,fg+:regular,bg+:-1,hl+:#6bdbd8,hl+:regular,query:regular \
  # --color=fg+:#ffffff,fg+:regular,bg+:#262626,hl+:#6bdbd8,hl+:regular,query:regular \
}
