{
  description = "Alacritty with configuration";

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
          config.allowUnfree = true;
          overlays = [
            (import ./overlays/lib.nix {
              rootStr = "/home/charles/terminal";
              inherit self;
            })
          ];
        };

        extraFonts = [
          pkgs.nerd-fonts.sauce-code-pro
          pkgs.nerd-fonts.monaspace
          pkgs.nerd-fonts.caskaydia-mono
        ];

        extraPackages =
          (import ./packages/commons.nix { inherit pkgs; })
          ++ (import ./packages/linux.nix { inherit pkgs system; })
          ++ [
            (import ./packages/wrappers/zsh.nix { inherit pkgs; })
            (import ./packages/wrappers/tmux.nix { inherit pkgs; })
            (import ./packages/wrappers/bash.nix { inherit pkgs; })
          ];

        alacritty = import ./packages/wrappers/alacritty.nix {
          inherit pkgs extraPackages extraFonts;
        };

        zsh = pkgs.symlinkJoin {
          name = "zsh";
          paths = extraPackages;
        };

      in
      {
        packages = {
          default = alacritty;
          zsh = zsh;
        };

        apps = {
          default = {
            type = "app";
            program = "${alacritty}/bin/alacritty";
          };
          zsh = {
            type = "app";
            program = "${zsh}/bin/zsh";
          };
        };
      }
    );
}
