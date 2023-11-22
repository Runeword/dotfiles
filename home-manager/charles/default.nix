{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./readline.nix
    ./ssh.nix
    # ./neovim.nix
    ./packages.nix
    ./bash
    ./sh
    ./zsh
    ./dircolors.nix
  ];

  programs = {
    home-manager.enable = true;
    vscode.enable = true;
    waybar.enable = true;
    waybar.package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    # obs-studio.enable = true;
    # obs-studio.plugins = with pkgs.obs-studio-plugins; [
    #   obs-gstreamer
    #   obs-pipewire-audio-capture
    #   obs-vkcapture
    #   wlrobs
    # ];
  };

  fonts.fontconfig.enable = true;

  home.username = "charles";
  home.homeDirectory = "/home/charles";
  home.stateVersion = "22.11";

  home.sessionVariables.EDITOR = "nvim";
  # home.sessionVariables.GRIMBLAST_EDITOR = "swappy";
  home.sessionVariables.VISUAL = "nvim";
  home.sessionVariables.MANPAGER = "nvim +Man!";

  nixpkgs.overlays = [
  ];

  # home.packages = [ inputs.src-cli.packages.x86_64-linux.default ];
  # xresources.properties."Xft.dpi" = 200;

  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';
}
