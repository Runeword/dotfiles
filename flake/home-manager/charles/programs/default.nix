{ config, pkgs, libs, ... }: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./i3.nix
    ./feh.nix
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
    ./wezterm.nix
  ];

  programs.home-manager.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.defaultCommand = "fd --hidden --follow --no-ignore --exclude .git --exclude node_modules"; # --strip-cwd-prefix
  programs.fzf.defaultOptions = [ "--reverse" "--height 40%" "--no-separator" "--border none" ];
  programs.fzf.fileWidgetCommand = config.programs.fzf.defaultCommand;
  # programs.fzf.fileWidgetOptions = config.programs.fzf.defaultOptions;

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.bashrcExtra = builtins.readFile ../extra/.bashrc;

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.options = [ "--no-cmd" ];
}
