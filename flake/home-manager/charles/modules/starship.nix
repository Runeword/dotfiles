{
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.enableNushellIntegration = true;

  programs.starship.settings = {
    add_newline = false;

    format = builtins.concatStringsSep "" [
      "$shell"
      "$nix_shell"
      "$all"
      "$git_branch"
      "$directory"
    ];

    shell.disabled = true;
    shell.bash_indicator = "b";
    shell.fish_indicator = "f";
    shell.zsh_indicator = "z";
    shell.format = "[$indicator]($style) ";

    directory.style = "blue";
    directory.format = "[$path/]($style) ";

    line_break.disabled = true;

    character.disabled = true;

    cmd_duration.disabled = true;
    cmd_duration.min_time = 10000;
    cmd_duration.format = "[$duration]($style) ";

    git_status.disabled = true;
    git_branch.format = "[$symbol $branch(:$remote_branch)]($style) ";
    git_branch.symbol = "🌳";
    git_branch.style = "white";

    nodejs.format = "[$symbol($version)]($style) ";
    nodejs.symbol = "node ";
    nodejs.style = "white";
    nodejs.version_format = "$\{raw\}";

    package.format = "[$symbol$version]($style) ";
    package.style = "white";

    lua.format = "[$symbol($version)]($style) ";
    lua.symbol = "lua ";
    lua.style = "white";
    lua.version_format = "$\{raw\}";

    nix_shell.format = "[$symbol]($style) ";
    nix_shell.symbol = "❄️";
  };
}
