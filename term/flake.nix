{
  description = "Alacritty with cowsay";

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
        pkgs = nixpkgs.legacyPackages.${system};

        alacrittyWithCowsay = pkgs.symlinkJoin {
          name = "alacritty-with-cowsay";
          paths = [
            pkgs.alacritty
            pkgs.cowsay
          ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/alacritty \
              --prefix PATH : ${pkgs.cowsay}/bin
          '';
        };

      in
      {
        packages.default = alacrittyWithCowsay;

        apps.default = {
          type = "app";
          program = "${alacrittyWithCowsay}/bin/alacritty";
        };
      }
    );
}
