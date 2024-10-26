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
        pkgs = nixpkgs.legacyPackages.${system};

        additionalPackages = with pkgs; [
          cowsay
          yazi
        ];

        alacrittyWithPackages = pkgs.symlinkJoin {
          name = "alacritty-with-packages";
          paths = [ pkgs.alacritty ] ++ additionalPackages;
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/alacritty \
              --prefix PATH : ${pkgs.lib.makeBinPath additionalPackages}
          '';
        };

      in
      {
        packages = {
          default = alacrittyWithPackages;
          runeword-alacritty = alacrittyWithPackages;
        };

        apps.default = {
          type = "app";
          program = "${alacrittyWithPackages}/bin/alacritty";
        };
      }
    );
}
