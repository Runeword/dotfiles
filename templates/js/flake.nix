{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {self, ...} @ inputs: let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
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
          pkgs.typescript
          pkgs.nodejs-23_x
          pkgs.deno
          pkgs.nodePackages.pnpm
        ];
      };
    };
  };
}
