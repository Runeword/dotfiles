{
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.enableNushellIntegration = true;

  programs.starship.settings = {
    format = builtins.concatStringsSep "" [
      "$shell"
      "$directory"
      "$nix_shell"
      "$all"
      "$git_branch"
    ];

    shell.disabled = false;
    shell.fish_indicator = "🐟";
    shell.bash_indicator = "";

    directory.style = "white";

    line_break.disabled = true;

    character.disabled = true;

    cmd_duration.disabled = true;
    cmd_duration.min_time = 10000;
    cmd_duration.format = "[$duration]($style) ";

    git_status.disabled = true;
    git_branch.format = "[$symbol $branch(:$remote_branch)]($style) ";
    git_branch.symbol = "🌱";
    git_branch.style = "white";

    nodejs.format = "[$symbol($version)]($style) ";
    nodejs.symbol = "node ";
    nodejs.style = "white";
    nodejs.version_format = "$\{raw\}";

    nix_shell.format = "[$symbol($name)]($style) ";
    nix_shell.symbol = "❄️ ";
    nix_shell.style = "white";
  };
}
