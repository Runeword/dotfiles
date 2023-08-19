{
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.enableNushellIntegration = true;

  programs.starship.settings = {
    add_newline = false;

    format = "$directory";

    right_format = builtins.concatStringsSep "" [
      "$git_branch"
      "$all"
      "$nix_shell"
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
    git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
    git_branch.symbol = "[󰊢](yellow) ";
    git_branch.style = "white";

    nodejs.format = "[$symbol($version)]($style) ";
    nodejs.version_format = "$\{raw\}";
    nodejs.symbol = "[󰎙](green) ";
    nodejs.style = "white";

    golang.format = "[$symbol($version)]($style) ";
    golang.version_format = "$\{raw\}";
    golang.symbol = "[](cyan) ";
    golang.style = "white";

    rust.format = "[$symbol($version)]($style) ";
    rust.version_format = "$\{raw\}";
    rust.symbol = "🦀";
    rust.style = "white";

    package.disabled = true;
    package.format = "[$symbol($version)]($style) ";
    package.version_format = "$\{raw\}";
    package.symbol = "[󰫈](purple) ";
    package.style = "white";

    lua.format = "[$symbol($version)]($style) ";
    lua.symbol = "lua ";
    lua.style = "white";
    lua.version_format = "$\{raw\}";

    nix_shell.format = "[$symbol]($style)";
    nix_shell.symbol = " ";
    # nix_shell.symbol = "❄️ ";
  };
}
