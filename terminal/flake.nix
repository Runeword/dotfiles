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

        mkOutOfStoreSymlink =
          path:
          let
            pathStr = toString path;
            name = builtins.baseNameOf pathStr;
            # relative path does not work when using the flake as input with home manager
            # fullPath = "${builtins.toString ./.}/${pathStr}";
            # need to use absolute path instead
            fullPath = "${builtins.toString /home/charles/terminal}/${pathStr}";
          in
          pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';

        extraFonts = [
          pkgs.nerd-fonts.sauce-code-pro
          pkgs.nerd-fonts.monaspace
          pkgs.nerd-fonts.caskaydia-mono
        ];

        commonPackages = (import ./packages/packages.nix { inherit pkgs; }) ++ [
        ];

        linuxPackages = pkgs.lib.optionals (system == "x86_64-linux" || system == "aarch64-linux") (
          import ./packages/linux-packages.nix { inherit pkgs; }
        );

        zsh = import ./packages/zsh.nix { inherit pkgs mkOutOfStoreSymlink; };
        tmux = import ./packages/tmux.nix { inherit pkgs mkOutOfStoreSymlink; };
        bash = import ./packages/bash.nix { inherit pkgs mkOutOfStoreSymlink; };

        extraPackages =
          commonPackages
          ++ linuxPackages
          ++ [
            zsh
            tmux
            bash
          ];

        alacritty =
          pkgs.runCommand "alacritty"
            {
              nativeBuildInputs = [ pkgs.makeWrapper ];
            }
            ''
              mkdir -p $out/bin $out/.config

              ln -sf ${mkOutOfStoreSymlink "config/alacritty"} $out/.config/alacritty

              # use makeWrapper instead of wrapProgram to preserve the original process name 'alacritty'
              # wrapProgram would have named it alacritty-wrapped instead
              makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
              --prefix PATH : ${pkgs.lib.makeBinPath extraPackages} \
              --set FONTCONFIG_FILE ${pkgs.makeFontsConf { fontDirectories = extraFonts; }} \
              --set XDG_CONFIG_HOME "$out/.config"
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
