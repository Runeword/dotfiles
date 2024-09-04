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
    # Programs
    inputs.neovim-runeword.packages.x86_64-linux.default
    alacritty
    kitty
    tmux
    tmuxPlugins.resurrect
    tmuxPlugins.tmux-fzf
    ueberzugpp
    yazi

    # Utilities
    wl-clipboard         # Copy/paste
    xdragon              # Drag and drop
  ];
}
