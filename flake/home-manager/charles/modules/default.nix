{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./kitty.nix
    # ./i3.nix # X11
    # ./feh.nix # X11
    # ./picom.nix # X11
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
    ./starship.nix
    ./broot.nix
    ./zoxide.nix
    ./fzf.nix
    ./home.nix
    ./packages.nix
    ./shellAliases.nix
    ./nushell.nix
    ./git.nix
    ./bash
    ./fish
    ./bat
    # ./eww
    # ./dircolors.nix
  ];


  services.fnott.enable = true;

  programs = {
    home-manager.enable = true;

    vscode.enable = true;

    jq.enable = true;

    waybar.enable = true;
    waybar.package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    fuzzel.enable = true;

    zsh.enable = true;
    zsh.enableAutosuggestions = true;
    zsh.enableCompletion = true;
    zsh.enableVteIntegration = true;
    zsh.autocd = false;
  };
  # environment.pathsToLink = [ "/share/zsh" ];
}
