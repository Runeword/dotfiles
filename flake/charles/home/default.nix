{ config, pkgs, lib, ... }: {
  imports = [ ./shellAliases.nix ];
  home.username = "charles";
  home.homeDirectory = "/home/charles";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    xfce.xfce4-pulseaudio-plugin
    git
    htop
    wget
    ripgrep
    fd
    vifm
    xclip
    chezmoi
    bat
    peek
    gcc
    slack
    python311
    nodejs-19_x
    neovim-nightly
    bitwarden-cli
    google-chrome
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
}
