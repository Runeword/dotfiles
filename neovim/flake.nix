{
  description = "My neovim flake";

  # nixConfig.extra-substituters = [
  #   "https://nix-community.cachix.org"
  # ];

  # nixConfig.extra-trusted-public-keys = [
  #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  # ];

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

  # inputs.neovim.url = "github:neovim/neovim?dir=contrib";
  # inputs.neovim.url = "github:neovim/neovim/stable?dir=contrib";
  # inputs.neovim.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    { self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
      };

      mkOutOfStoreSymlink = 
        path:
        let
          pathStr = toString path;
          name = builtins.baseNameOf pathStr;
          # fullPath = "${toString /home/charles/neovim}/${pathStr}";
          fullPath = "${builtins.toString ./.}/${pathStr}";
        in
        pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';

      neovim-override = pkgs.neovim.override {
        # withPython3 = true;
        # withNodeJs = true;
        # package = pkgs.neovim-nightly;
      };

      neovim-with-dependencies = pkgs.symlinkJoin {
        name = "neovim";
        paths = [ neovim-override ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = with pkgs; ''
          mkdir -p $out/.config
          ln -sf ${mkOutOfStoreSymlink "config"} $out/.config/nvim

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
      };
    in
    {
      apps.${system} = {
        default = {
          type = "app";
          program = "${neovim-with-dependencies}/bin/nvim";
        };
      };

      packages.${system} = {
        default = neovim-with-dependencies;
        runeword-neovim = neovim-with-dependencies;
      };
    };
}

# Run the flake :
# nix run "github:Runeword/dotfiles?dir=neovim"
# nix run $HOME/neovim

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
