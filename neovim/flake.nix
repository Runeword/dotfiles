{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";

  outputs = { self, ... }@inputs:
  let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
  };
  nvim = pkgs.wrapNeovim pkgs.neovim-nightly {
    # extraMakeWrapperArgs = ''--prefix PATH : "${pkgs.lib.makeBinPath [pkgs.fzf]}"'';
    configure = {
      # customRC = "set relativenumber";
      customRC = ''
      lua << EOF
      ${builtins.readFile ~/flake/config/nvim/init.lua}
      EOF
    '';
    };
  };

  in {
    packages.x86_64-linux.default = nvim;
    apps.x86_64-linux.default = { type = "app"; program = "${nvim}/bin/nvim"; };
  };
}
