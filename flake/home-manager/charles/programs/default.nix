{ config, pkgs, lib, ... }: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./kitty.nix
    ./i3.nix
    ./feh.nix
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
    ./starship.nix
    # ./xmonad.nix
    # ./wezterm.nix
  ];

  programs.home-manager.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.defaultCommand = "fd --hidden --follow --no-ignore --exclude .git --exclude node_modules"; # --strip-cwd-prefix
  # programs.fzf.defaultOptions = [ "--reverse" "--height 40%" "--no-separator" "--border none" "--bind tab:down" "--bind shift-tab:up" "--bind ctrl-space:select"];
  programs.fzf.defaultOptions = [ "--reverse" "--no-separator" "--border none" ];
  programs.fzf.fileWidgetCommand = config.programs.fzf.defaultCommand;
  # programs.fzf.fileWidgetOptions = config.programs.fzf.defaultOptions;

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.bashrcExtra = builtins.readFile ../extra/.bashrc;

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.options = [ "--no-cmd" ];

  programs.git.enable = true;
  programs.git.userEmail = "60324746+Runeword@users.noreply.github.com";
  programs.git.userName = "Runeword";
  # programs.git.delta.enable = true;

  programs.vscode.enable = true;

  programs.jq.enable = true;

  programs.direnv.enable = true;
  programs.direnv.enableBashIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.bat.enable = true;
  programs.bat.config.theme = "Nord";
}
