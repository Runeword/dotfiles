{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.username = "charles";
  home.homeDirectory = "/home/charles";
  home.stateVersion = "22.11";

  # home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";
  home.sessionVariables.MANPAGER = "nvim +Man!";

  nixpkgs.overlays = [
  ];
}
