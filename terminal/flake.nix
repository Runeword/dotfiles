{
  description = "Alacritty with additional packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Initialize nixpkgs
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Helper function for creating symlinks to config files
        mkOutOfStoreSymlink = path:
          let
            pathStr = toString path;
            name = builtins.baseNameOf pathStr;
            fullPath = "${toString /home/charles/terminal}/${pathStr}";
          in
          pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';

        # Basic packages that don't depend on anything custom
        standardExtraPackages = import ./packages/extraPackages.nix { inherit pkgs; };

        # Define packages in order of dependency
        customZsh = import ./packages/zsh.nix { 
          inherit pkgs mkOutOfStoreSymlink; 
        };
        
        customTmux = import ./packages/tmux.nix { 
          pkgs = pkgs // { zsh = customZsh; }; 
          inherit mkOutOfStoreSymlink; 
        };
        
        customLeader = import ./packages/leader.nix { 
          inherit pkgs; 
        };

        # Build alacritty with all other packages
        customAlacritty = import ./packages/alacritty.nix {
          pkgs = pkgs // { 
            zsh = customZsh;
            tmux = customTmux;
            leader = customLeader;
          };
          inherit mkOutOfStoreSymlink;
          extraPackages = standardExtraPackages ++ [
            customZsh
            customTmux
            customLeader
          ];
        };

      in {
        packages = {
          default = customAlacritty;
          alacritty = customAlacritty;
          tmux = customTmux;
          leader = customLeader;
          zsh = customZsh;
        };

        apps = {
          default = {
            type = "app";
            program = "${customAlacritty}/bin/alacritty";
          };
          tmux = {
            type = "app";
            program = "${customTmux}/bin/tmux";
          };
          zsh = {
            type = "app";
            program = "${customZsh}/bin/zsh";
          };
        };
      }
    );
}
