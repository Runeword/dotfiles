{
  description = "My neovim flake";

  # Enable binary cache from nix-community to download pre-built packages,
  # such as neovim-nightly-overlay, instead of building them locally.
  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  # Required to creates outputs for all supported systems
  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    let
      config = {
        flakeDir = builtins.getEnv "NVIM_CONFIG_DIR";
      };

      baseStr = config.flakeDir;
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import ./overlays/lib.nix {
              inherit baseStr self;
            })
            inputs.neovim-nightly-overlay.overlays.default
          ];
        };

        neovim-override = pkgs.neovim.override {
          # withPython3 = true;
          # withNodeJs = true;
          # package = pkgs.neovim-nightly;
        };

        wrapper = with pkgs; ''
          rm $out/bin/nvim
          makeWrapper ${neovim-override}/bin/nvim $out/bin/nvim --prefix PATH : ${
            lib.makeBinPath [
              fzf
              sox
              typescript-language-server
              bash-language-server
              eslint
              eslint_d
              vue-language-server
              pyright
              vscode-langservers-extracted
              yaml-language-server
              lua-language-server
              selene
              marksman
              ccls
              nil
              alejandra
              nixfmt-rfc-style
              shfmt
              shellcheck
              shellharden
              terraform-ls
              gopls
              delve
              rust-analyzer
              taplo
              black
              isort
              harper
              # typos-lsp
            ]
          } \
          --set XDG_CONFIG_HOME "$out/.config"
        '';

        neovim-dev = pkgs.symlinkJoin {
          name = "neovim";
          paths = [ neovim-override ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            mkdir -p $out/.config
            ${pkgs.lib.mkLink "config" ".config/nvim"}
            ${wrapper}
          '';
        };

        neovim = pkgs.symlinkJoin {
          name = "neovim";
          paths = [ neovim-override ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            mkdir -p $out/.config
            cp -r ${./config} $out/.config/nvim
            ${wrapper}
          '';
        };
      in
      {
        apps.default.type = "app";
        apps.default.program = "${neovim}/bin/nvim";
        packages.default = neovim;

        apps.dev.type = "app";
        apps.dev.program = "${neovim-dev}/bin/nvim";
        packages.dev = neovim-dev;
      }
    );
}

# Run the flake :
# nix run "github:Runeword/dotfiles?dir=neovim#dev" --no-write-lock-file
# nix run "github:Runeword/dotfiles?dir=neovim" --option substituters "https://runeword-neovim.cachix.org" --option trusted-public-keys "runeword-neovim.cachix.org-1:Vvtv02wnOz9tp/qKztc9JJaBc9gXDpURCAvHiAlBKZ4="
# NVIM_CONFIG_DIR=$HOME/neovim nix run $HOME/neovim#dev --impure

# {
#   description = "My own Neovim flake";
#   # # inputs.neovim.url = "github:neovim/neovim/v0.8.3?dir=contrib";
#   inputs.neovim.url = "github:neovim/neovim/nightly?dir=contrib";
#   inputs.neovim.inputs.nixpkgs.follows = "nixpkgs";
#   inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
# outputs = { self, nixpkgs, neovim }: {
#   packages.x86_64-linux.default = neovim.packages.x86_64-linux.neovim;
#   apps.x86_64-linux.default = {
#     type = "app";
#     program = "${neovim.packages.x86_64-linux.neovim}/bin/nvim";
#   };
# };
