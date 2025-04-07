{
  description = "Alacritty with additional packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        lib = import ./lib { inherit pkgs; };

        packages = import ./packages {
          inherit pkgs;
          inherit lib;
        };

      in
      {
        packages = {
          default = packages.alacritty;
          inherit (packages)
            alacritty
            tmux
            leader
            zsh
            ;
        };

        apps = {
          default = {
            type = "app";
            program = "${packages.alacritty}/bin/alacritty";
          };
          tmux = {
            type = "app";
            program = "${packages.tmux}/bin/tmux";
          };
          zsh = {
            type = "app";
            program = "${packages.zsh}/bin/zsh";
          };
        };
      }
    );
}
