{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  # inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=b12803b6d90e2e583429bb79b859ca53c348b39a";
  # inputs.nixpkgs.url = "github:nixos/nixpkgs";

  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  inputs.hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  # inputs.hyprland.inputs.nixpkgs.follows = "nixpgks";
  # inputs.hyprland.inputs.nixpkgs.follows = "nixpkgs-unstable";
  # inputs.hyprland.inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=b12803b6d90e2e583429bb79b859ca53c348b39a";

  outputs =
    { self, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.charles = inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };
    };
}
