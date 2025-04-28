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
            (import ./overlays/lib.nix { rootStr = "/home/charles/terminal"; inherit self; })
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

        alacritty =
          pkgs.runCommand "alacritty"
            {
              nativeBuildInputs = [ pkgs.makeWrapper ];
            }
            ''
              ${pkgs.lib.mkLink "config/alacritty" ".config/alacritty"}

              # use makeWrapper instead of wrapProgram to preserve the original process name 'alacritty'
              # wrapProgram would have named it alacritty-wrapped instead
              mkdir -p $out/bin
              makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
              --prefix PATH : ${pkgs.lib.makeBinPath extraPackages} \
              --set FONTCONFIG_FILE ${pkgs.makeFontsConf { fontDirectories = extraFonts; }} \
              --add-flags "--config-file $out/.config/alacritty/alacritty.toml" \
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
