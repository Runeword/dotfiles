{ config
, pkgs
, lib
, inputs
, ...
}: {
  imports = [
    ./overlays.nix
    ./packages.nix
    # ./bash.nix
    ./zsh.nix
    inputs.ags.homeManagerModules.default
  ];

  # services.gpg-agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-curses;
  # };

  gtk = {
    enable = true;
    # font = {
    # };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
  };

  programs = {
    home-manager.enable = true;

    ags = {
      enable = true;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

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
