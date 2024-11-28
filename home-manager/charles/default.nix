{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./overlays.nix
    ./packages.nix
    ./desktop.nix
    # inputs.ags.homeManagerModules.default
    # inputs.walker.homeManagerModules.default
  ];

  # services.gpg-agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-curses;
  # };

  gtk.enable = true;
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3";
  gtk.cursorTheme.package = pkgs.adwaita-icon-theme;
  gtk.cursorTheme.name = "Adwaita";
  gtk.cursorTheme.size = 24;
  gtk.iconTheme.name = "Adwaita";
  gtk.iconTheme.package = pkgs.adwaita-icon-theme;

  # programs.walker = {
  #   enable = true;
  #   runAsService = true;
  #   config = {
  #     search.placeholder = "Example";
  #     ui.fullscreen = true;
  #     list = {
  #       height = 200;
  #     };
  #     websearch.prefix = "?";
  #     switcher.prefix = "/";
  #   };
  # };

  # home.sessionVariables = {
  #   XDG_DATA_DIRS = "/usr/local/share:/usr/share";
  #   XDG_CONFIG_DIRS = "/etc/xdg";
  #   XDG_CACHE_HOME = "$HOME/.cache";
  #   XDG_CONFIG_HOME = "$HOME/.config";
  #   XDG_DATA_HOME = "$HOME/.local/share";
  #   XDG_STATE_HOME = "$HOME/.local/state";
  #   XDG_BIN_HOME = "$HOME/.local/bin";
  # };

  xdg.mime.enable = true;

  programs.rofi.enable = true;

  programs = {
    home-manager.enable = true;

    # ags = {
    #   enable = true;

    #   # additional packages to add to gjs's runtime
    #   extraPackages = with pkgs; [
    #     gtksourceview
    #     webkitgtk
    #     accountsservice
    #   ];
    # };

    # direnv.enable = true;
    # direnv.nix-direnv.enable = true;

    # gpg.enable = true;
    # gpg.homedir = "${config.home.homeDirectory}/.config/gnupg";

    obs-studio.enable = true;
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

  # xresources.properties."Xft.dpi" = 200;
  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';
}
