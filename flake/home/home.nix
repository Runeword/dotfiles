{ config, pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;

  home.shellAliases = import ./shellAliases.nix;
  home.username = "charles";
  home.homeDirectory = "/home/charles";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    git
    htop
    wget
    ripgrep
    fd
    vifm
    xclip
    chezmoi
    bat
    gcc
    python311
    nodejs-19_x
    alacritty
    neovim-nightly
    bitwarden-cli
    google-chrome
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  imports = [ ./programs ];
  }
