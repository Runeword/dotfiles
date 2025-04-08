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
          config.allowUnfree = true;
        };

        # Helper function for symlinks
        mkOutOfStoreSymlink =
          path:
          let
            pathStr = toString path;
            name = builtins.baseNameOf pathStr;
            fullPath = "${builtins.toString ./.}/${pathStr}";
          in
          pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';

        # Build packages in dependency order
        zsh = import ./packages/zsh.nix { inherit pkgs mkOutOfStoreSymlink; };

        tmux = import ./packages/tmux.nix {
          inherit mkOutOfStoreSymlink;
          pkgs = pkgs // {
            zsh = zsh;
          };
        };

        leader = import ./packages/leader.nix { inherit pkgs; };

        # Package list for Alacritty
        packageList = (import ./packages/extraPackages.nix { inherit pkgs; }) ++ [
          zsh
          tmux
          leader
        ];

        # Build Alacritty with the complete package list
        alacritty = import ./packages/alacritty.nix {
          inherit mkOutOfStoreSymlink;
          pkgs = pkgs;
          extraPackages = packageList;
        };

      in
      {
        packages = {
          default = alacritty;
          inherit
            alacritty
            tmux
            leader
            zsh
            ;
        };

        apps = {
          default = {
            type = "app";
            program = "${alacritty}/bin/alacritty";
          };
          tmux = {
            type = "app";
            program = "${tmux}/bin/tmux";
          };
          zsh = {
            type = "app";
            program = "${zsh}/bin/zsh";
          };
        };
      }
    );
}
