{
  nixConfig.extra-substituters = [
    # "https://walker-git.cachix.org"
    "https://runeword-neovim.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    # "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    "runeword-neovim.cachix.org-1:Vvtv02wnOz9tp/qKztc9JJaBc9gXDpURCAvHiAlBKZ4="
  ];

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.hyprland-contrib.url = "github:hyprwm/contrib";
  inputs.hyprland-contrib.inputs.nixpkgs.follows = "nixpkgs";

  # inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  # inputs.neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  ## inputs.neovim-nightly-overlay.inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";

  inputs.runeword-neovim.url = "github:Runeword/dotfiles?dir=neovim";
  inputs.runeword-terminal.url = "github:Runeword/dotfiles?dir=term";

  inputs.ags.url = "github:Aylur/ags";
  inputs.hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  # inputs.walker.url = "github:abenz1267/walker";

  # inputs.src-cli.url = "github:sourcegraph/src-cli?dir=contrib";
  # inputs.nixified-ai.url = "github:nixified-ai/flake";

  outputs =
    { self, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations.charles = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            inputs.hyprpanel.overlay
            #   inputs.neovim-nightly-overlay.overlay
          ];
        };

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ./charles
        ];
      };

      homeConfigurations.zod = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ./zod
        ];
      };
    };
}
