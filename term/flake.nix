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

        mkOutOfStoreSymlink = import ./lib/mkOutOfStoreSymlink.nix { inherit pkgs; };

        customPackages.leader = import ./packages/leader.nix { inherit pkgs; };

        customTmux = import ./packages/tmux.nix {
          inherit pkgs;
          inherit mkOutOfStoreSymlink;
        };

        packagesModule = import ./modules/packages.nix {
          inherit pkgs;
          inherit customTmux;
        };
        extraPackages = packagesModule.extraPackages ++ [ customPackages.leader ];
        extraFonts = packagesModule.extraFonts;

        customAlacritty = import ./packages/alacritty.nix {
          inherit pkgs;
          inherit mkOutOfStoreSymlink;
          inherit extraPackages;
          inherit extraFonts;
        };

      in
      {
        packages = {
          default = customAlacritty;
          customAlacritty = customAlacritty;
          customTmux = customTmux;
        };

        apps = {
          default = {
            type = "app";
            program = "${customAlacritty}/bin/alacritty";
          };
          customTmux = {
            type = "app";
            program = "${customTmux}/bin/tmux";
          };
        };
      }
    );
}
