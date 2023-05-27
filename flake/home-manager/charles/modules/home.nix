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

  nixpkgs.overlays = [
  ];
}
