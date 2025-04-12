{
  description = "Alacritty with configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Helper function for symlinks - same as in your Neovim config
        mkOutOfStoreSymlink = path:
          let
            pathStr = toString path;
            name = builtins.baseNameOf pathStr;
            fullPath = "${builtins.toString ./.}/${pathStr}";
          in
          pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';

        extraFonts = [
          pkgs.nerd-fonts.sauce-code-pro
          pkgs.nerd-fonts.monaspace
          pkgs.nerd-fonts.caskaydia-mono
        ];

        alacritty = pkgs.runCommand "alacritty" {
          nativeBuildInputs = [ pkgs.makeWrapper ];
        } ''
          mkdir -p $out/bin $out/.config
          
          # Link to your alacritty config, exactly as Neovim does with its config
          ln -sf ${mkOutOfStoreSymlink "alacritty"} $out/.config/alacritty
          
          makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
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
