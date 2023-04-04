{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  # inputs.neovim-nightly-overlay.inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";

  inputs.nixified-ai.url = "github:nixified-ai/flake";

  outputs = {self, ...} @ inputs: let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
      extraSpecialArgs = {inherit inputs;};
    };
  in {
    nixosConfigurations.charles = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs.inputs = inputs;
      modules = [
        nixos/configuration.nix
        nixos/hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
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
          pkgs.nodePackages.typescript
          pkgs.nodejs-19_x
          pkgs.deno
          pkgs.nodePackages.pnpm
          pkgs.nodePackages.npm
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
