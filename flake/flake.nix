{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  # inputs.neovim-nightly-overlay.inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";

  inputs.src-cli.url = "github:sourcegraph/src-cli?dir=contrib";
  inputs.nixified-ai.url = "github:nixified-ai/flake";

  outputs = {self, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.charles = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {inherit inputs;};

      modules = [
        nixos/configuration.nix
        nixos/hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
      ];
    };

    homeConfigurations.charles = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.neovim-nightly-overlay.overlay
        ];
      };

      extraSpecialArgs = {inherit inputs;};

      modules = [
        home-manager/charles
      ];
    };
  };
}
