{ pkgs
, inputs
, lib
, config
, ...
  }:
  let
  leader = pkgs.stdenv.mkDerivation {
    pname = "leader";
    version = "0.3.2";
    src = pkgs.fetchurl {
      url = "https://github.com/dhamidi/leader/releases/download/v0.3.2/leader.linux.amd64";
      sha256 = "sha256-lwOChHRvDvOm371v5xZUXS//6Dgn4CljioMrIBbWgwY=";
    };
    
    dontUnpack = true;
    
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/leader
      chmod +x $out/bin/leader
    '';
  };
  in
  {
  home.packages = with pkgs; [
    # Editors
    inputs.neovim-runeword.packages.x86_64-linux.default
    alacritty
    kitty
    tmux
    tmuxPlugins.resurrect
    tmuxPlugins.tmux-fzf
    ueberzugpp
    yazi

    # Coreutils
    fzf
    bat
    wget
    ripgrep
    fd
    tree
    jq

    # Apps
    leader
    navi
    zoxide
    gomi

    # Utilities
    wl-clipboard         # Copy/paste
    xdragon              # Drag and drop

    # Archivers
    ouch
    xarchiver
    unzip
    # zip
    # p7zip

    # Secrets
    pass-wayland
    gnupg
    pinentry-curses
    # gpg-tui

    # UI
    starship
  ];
}
