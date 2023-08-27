{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./ssh.nix
    ./neovim.nix
    ./broot.nix
    ./home.nix
    ./packages.nix
    ./git.nix
    ./bash
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

    obs-studio.enable = true;
    obs-studio.plugins = with pkgs.obs-studio-plugins; [
      obs-gstreamer
      obs-pipewire-audio-capture
      obs-vkcapture
      wlrobs
    ];
  };

  fonts.fontconfig.enable = true;

  # home.packages = [ inputs.src-cli.packages.x86_64-linux.default ];
  # xresources.properties."Xft.dpi" = 200;

  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';
}
