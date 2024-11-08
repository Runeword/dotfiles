{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
# let
  # leader = pkgs.stdenv.mkDerivation {
  #   pname = "leader";
  #   version = "0.3.2";
  #   src = pkgs.fetchurl {
  #     url = "https://github.com/dhamidi/leader/releases/download/v0.3.2/leader.linux.amd64";
  #     sha256 = "sha256-lwOChHRvDvOm371v5xZUXS//6Dgn4CljioMrIBbWgwY=";
  #   };

  #   dontUnpack = true;

  #   installPhase = ''
  #     mkdir -p $out/bin
  #     cp $src $out/bin/leader
  #     chmod +x $out/bin/leader
  #   '';
  # };
# in
{
  home.packages = with pkgs; [
    inputs.neovim-runeword.packages.x86_64-linux.default # Text editor
    kitty                 # Terminal emulator
    tmux                  # Sessions, windows and panes manager
    tmuxPlugins.tmux-fzf  # Fuzzy search tmux sessions, windows and panes
    tmuxPlugins.resurrect # Save and restore tmux environment
    # bemenu

    # Secrets
    doppler
    bitwarden-cli

    # Secrets
    pass-wayland
    gnupg
    pinentry-curses
    # gpg-tui
  ];
}
