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
  --border none --color=fg:#d0d0d0,bg:-1,hl:#7e6fc4 \
  --color=fg+:#ffffff,bg+:-1,hl+:#3dd4a5 \
  --color=info:#d0d0d0,prompt:#ffffff,pointer:#3dd4a5 \
  --color=marker:#3dd4a5,spinner:#ffffff,header:#d0d0d0
  ";
}
