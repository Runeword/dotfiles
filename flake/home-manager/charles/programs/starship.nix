{
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.settings = {
    line_break.disabled = true;
    character.disabled = true;
    cmd_duration.disabled = true;
    cmd_duration.min_time = 10000;
    cmd_duration.format = "[$duration]($style) ";
    git_status.disabled = true;
    git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
    git_branch.symbol = "󰊢 ";
    nodejs.format = "[$symbol($version)]($style) ";
    nodejs.symbol = "󰎙 ";
    nodejs.version_format = "$\{raw\}";
    nix_shell.format = "[$symbol($name)]($style) ";
    nix_shell.symbol = "󱄅 ";
  };
}
