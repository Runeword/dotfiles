{ pkgs
, inputs
, lib
, config
, ...
  }:
  let
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

    # Essentials
    navi
    fzf
    starship
    zoxide
    bat
    wget
    ripgrep
    fd
    unzip
    tree
    leader
    jq
    gomi

    # Archivers
    ouch
    xarchiver
    # zip
    # unzip
    # p7zip

    # Utilities
    wl-clipboard         # Copy/paste
    xdragon              # Drag and drop
  ];
}
