{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  inputs.hyprland.url = "github:hyprwm/Hyprland";

  inputs.hyprland-contrib.url = "github:hyprwm/contrib";
  inputs.hyprland-contrib.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {self, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.charles = inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
      ];
    };
  };
}
