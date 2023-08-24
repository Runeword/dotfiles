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

    # obs-studio.enable = true;
    # obs-studio.plugins = [
    #   pkgs.obs-studio-plugins.wlrobs
    # ];
  };

  fonts.fontconfig.enable = true;

  # home.packages = [ inputs.src-cli.packages.x86_64-linux.default ];
  # xresources.properties."Xft.dpi" = 200;

  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';

  # xdg.mime.enable = true;
  # xdg.mimeApps.enable = true;
  # xdg.mimeApps.defaultApplications = {
  #   "application/zip" = ["xarchiver.desktop"];
  #
  #   "image/jpeg" = ["imv.desktop"];
  #   "image/png" = ["imv.desktop"];
  #   "image/avif" = ["imv.desktop"];
  #   "image/bmp" = ["imv.desktop"];
  #   "image/tiff" = ["imv.desktop"];
  #   "image/svg+xml" = ["imv.desktop"];
  #   "image/gif" = ["imv.desktop"];
  #   "image/vnd.microsoft.icon" = ["imv.desktop"];
  #   "image/webp" = ["imv.desktop"];
  #
  #   "application/json" = ["nvim.desktop"];
  #   "application/ld+json" = ["nvim.desktop"];
  #   "application/x-sh" = ["nvim.desktop"];
  #   "application/xml" = ["nvim.desktop"];
  #   "text/plain" = ["nvim.desktop"];
  #   "text/css" = ["nvim.desktop"];
  #   "text/csv" = ["nvim.desktop"];
  #   "text/html" = ["nvim.desktop"];
  #   "text/calendar" = ["nvim.desktop"];
  #   "text/javascript" = ["nvim.desktop"];

  # [Added Associations]
  # application/zip=userapp-unzip-S2SZ71.desktop;
  #
  # [Default Applications]
  # application/json=nvim.desktop
  # application/ld+json=nvim.desktop
  # application/x-sh=nvim.desktop
  # application/xml=nvim.desktop
  # application/zip=userapp-unzip-S2SZ71.desktop
  # image/avif=imv.desktop
  # image/bmp=imv.desktop
  # image/gif=imv.desktop
  # image/jpeg=imv.desktop
  # image/png=imv.desktop
  # image/svg+xml=imv.desktop
  # image/tiff=imv.desktop
  # image/vnd.microsoft.icon=imv.desktop
  # image/webp=imv.desktop
  # text/calendar=nvim.desktop
  # text/css=nvim.desktop
  # text/csv=nvim.desktop
  # text/html=nvim.desktop
  # text/javascript=nvim.desktop
  # text/plain=nvim.desktop
  #
  # [Removed Associations]
  # };
}
