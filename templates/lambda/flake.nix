{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {self, ...} @ inputs: let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      # overlays = [
      #   (self: super: {
      #     aws-sam-cli = super.aws-sam-cli.overrideAttrs (old: {
      #       src = super.fetchFromGitHub {
      #         owner = "aws";
      #         repo = "aws-sam-cli";
      #         rev = "v1.100.0";
      #         # rev = "f38e17dcb60336dc83893770ec09def8ce637459";
      #         sha256 = "sha256-BmYBo3jq6vTZvtLB9/5QtGYOVIVttHcEm2x0oIl1Qs0=";
      #         # sha256 = pkgs.lib.fakeSha256;
      #       };
      #     });
      #   })
      # ];
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
