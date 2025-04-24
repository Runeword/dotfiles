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
              --set FLAKE_DIR "${utils.flakePath}"
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
