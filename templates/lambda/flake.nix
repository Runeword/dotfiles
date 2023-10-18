{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {self, ...} @ inputs: let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      overlays = [
        (self: super: {
          aws-sam-cli = super.aws-sam-cli.overrideAttrs (old: {
            src = super.fetchFromGitHub {
              owner = "aws";
              repo = "aws-sam-cli";
              rev = "v1.98.0";
              sha256 = "sha256-ksdNPe5yBoMj4vHCHayfZ5O8BrH8zqUMefJDxvvHOYs=";
              # sha256 = pkgs.lib.fakeSha256;
            };
          });
        })
      ];
    };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        pkgs.go
        pkgs.aws-sam-cli
      ];
    };
  };
}
