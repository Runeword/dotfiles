{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  outputs = {self, ...} @ inputs: let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
      ];
    };
  in {
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
