{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
    ./starship.nix
    ./broot.nix
    ./zoxide.nix
    ./fzf.nix
    ./home.nix
    ./packages.nix
    ./git.nix
    ./bash
    ./bat
    ./sh
    ./zsh
    ./dircolors.nix
  ];

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

    zellij.enable = true;

    # obs-studio.enable = true;
    # obs-studio.plugins = [
    #   pkgs.obs-studio-plugins.wlrobs
    # ];
  };
}
