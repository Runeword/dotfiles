{
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enableFishIntegration = true;
  programs.zoxide.options = ["--no-cmd"];
  home.sessionVariables._ZO_FZF_OPTS = "--reverse --height 40% --no-separator --border none"; # fzf options
  home.shellAliases.cd = "__zoxide_z";
  home.shellAliases.ch = "__zoxide_zi";
}
