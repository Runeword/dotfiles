{
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, ... }@inputs: {
    homeConfigurations.charles = inputs.home-manager.lib.homeManagerConfiguration {

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [
          inputs.neovim-nightly-overlay.overlay
        ];
      };

      modules = [
        ./home.nix
      ];
    };
  };
}
