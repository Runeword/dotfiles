{ config, pkgs, libs, ... }: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./i3.nix
    ./feh.nix
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
  ];

  programs.home-manager.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.fileWidgetCommand = "fd --hidden --follow --no-ignore --max-depth 1 --exclude .git --exclude node_modules";
  programs.fzf.defaultOptions = [ "--no-separator" ];

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.bashrcExtra = builtins.readFile ../extra/.bashrc;
}
