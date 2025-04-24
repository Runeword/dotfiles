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
        };

        utils = import ./lib/utils.nix { inherit pkgs; };

        extraFonts = [
          pkgs.nerd-fonts.sauce-code-pro
          pkgs.nerd-fonts.monaspace
          pkgs.nerd-fonts.caskaydia-mono
        ];

        packages = import ./packages { inherit pkgs utils system; };

        extraPackages = packages.common ++ packages.linux ++ packages.custom;

        findFlakeDir = pkgs.writeScriptBin "find-flake-dir" ''
          #!/bin/sh
          set -e

          find_up() {
            current_dir="$PWD"
            flake_file="flake.nix"

            while true; do
              if [ -f "$current_dir/$flake_file" ]; then
                echo "$current_dir"
                exit 0
              fi

              if [ "$current_dir" = "/" ]; then
                echo "ERROR: Unable to locate flake.nix in any parent directory" >&2
                exit 1
              fi

              current_dir="$(dirname "$current_dir")"
            done
          }

          find_up
        '';

        alacritty =
          pkgs.runCommand "alacritty"
            {
              nativeBuildInputs = [ pkgs.makeWrapper ];
            }
            ''
              mkdir -p $out/bin $out/.config

              ln -sf ${utils.mkOutOfStoreSymlink "config/alacritty"} $out/.config/alacritty

              # use makeWrapper instead of wrapProgram to preserve the original process name 'alacritty'
              # wrapProgram would have named it alacritty-wrapped instead
              makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
              --prefix PATH : ${pkgs.lib.makeBinPath extraPackages} \
              --set FONTCONFIG_FILE ${pkgs.makeFontsConf { fontDirectories = extraFonts; }} \
              --set XDG_CONFIG_HOME "$out/.config" \
              --run 'export FLAKE_DIR="$(${findFlakeDir}/bin/find-flake-dir)"'
            '';
      in
      {
        packages = {
          default = alacritty;
        };

        apps = {
          default = {
            type = "app";
            program = "${alacritty}/bin/alacritty";
          };
        };
      }
    );
}
