{
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  # inputs.neovim-nightly-overlay.inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";

  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, ... }@inputs:
  let pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
  };

  in {
    nixosConfigurations.charles = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        nixos/hardware-configuration.nix
        nixos/configuration.nix
      ];
    };

    homeConfigurations.charles = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        home-manager/charles
      ];
    };

    devShells.x86_64-linux = {
      default = pkgs.mkShell {
        packages = [
          pkgs.nodejs-19_x
        ];
      };

      js = pkgs.mkShell {
        packages = [
          pkgs.nodejs-19_x
        ];
        shellHook = ''
        nl="npm ls --depth=0";
        nlg="npm ls -g --depth=0";
        nd="npm run dev";
        ni="npm i";
        '';
      };
    };
  };
}
