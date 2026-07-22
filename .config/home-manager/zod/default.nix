{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
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

  home.sessionVariables = {
    XDG_DATA_DIRS = "/usr/local/share:/usr/share";
    XDG_CONFIG_DIRS = "/etc/xdg";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";
  };

  xdg.mime.enable = false;

  programs = {
    home-manager.enable = true;

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    # gpg.enable = true;
    # gpg.homedir = "${config.home.homeDirectory}/.config/gnupg";
  };

  # fonts.fontconfig.enable = true;

  home.username = "zod";
  home.homeDirectory = "/home/zod";
  home.stateVersion = "22.11";
}
