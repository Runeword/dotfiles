{
  imports = [
    ./aliases.nix
  ];

  # fzf
  home.sessionVariables._ZO_FZF_OPTS = "--reverse --height 40% --no-separator --border none";
  home.sessionVariables.FZF_DEFAULT_COMMAND = "fd --hidden --follow --no-ignore --exclude .git --exclude node_modules";
  home.sessionVariables.FZF_DEFAULT_OPTS = "
  --reverse \
  --no-separator \
  --info=inline:'' \
  --border none --color=fg:#d0d0d0,bg:-1,hl:#7e6fc4 \
  --color=fg+:#ffffff,bg+:-1,hl+:#ed725c,query:regular \
  --color=info:#d0d0d0,prompt:#ffffff,pointer:#ed725c \
  --color=marker:#ed725c,spinner:#ffffff,header:#d0d0d0 \
  --prompt='  ' \
  ";
}
