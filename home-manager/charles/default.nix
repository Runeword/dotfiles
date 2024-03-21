{ config
, pkgs
, lib
, inputs
, ...
}: {
  imports = [
    ./ssh.nix
    ./overlays.nix
    ./aliases.nix
    ./sessionVariables.nix
    ./packages.nix
    ./bash.nix
    ./zsh.nix
    # ./dircolors.nix
    # ./neovim.nix
  ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs = {
    home-manager.enable = true;

    vscode.enable = true;

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    gpg.enable = true;
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
