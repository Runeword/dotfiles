{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {self, ...} @ inputs: let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      # overlays = [
        # (self: super: {
        #   supabase-cli = super.supabase-cli.override (old: {
        #     buildGoModule = args:
        #       pkgs.buildGoModule (args
        #         // {
        #           version = "1.50.3";
        #           src = super.fetchFromGitHub {
        #             owner = "supabase";
        #             repo = "cli";
        #             rev = "v1.50.3";
        #             sha256 = "sha256-fj8kMvHSs1ZOnMgyaWAyIAwzK6LJz0gxhJ+Dpf5hwis=";
        #           };
        #           ldflags = ["-s" "-w" "-X" "github.com/supabase/cli/cmd.version=1.50.3"];
        #           vendorSha256 = "sha256-bxqfg77f6BuUy+9KrcToWJRzfwshOdqEQkAq4IFaxS8=";
        #           postInstall = ''
        #             rm $out/bin/{codegen,listdep}
        #             mv $out/bin/{cli,supabase}
        #             installShellCompletion --cmd supabase \
        #               --bash <($out/bin/supabase completion bash) \
        #               --fish <($out/bin/supabase completion fish) \
        #               --zsh <($out/bin/supabase completion zsh)
        #           '';
        #         });
        #   });
        # })

        ## supabase-cli = super.supabase-cli.overrideAttrs (old: {
        ##   src = super.fetchFromGitHub {
        ##     owner = "supabase";
        ##     repo = "cli";
        ##     rev = "v1.45.1";
        ##     sha256 = "sha256-fj8kMvHSs1ZOnMgyaWAyIAwzK6LJz0gxhJ+Dpf5hwis=";
        ##   };
        ##   ldflags = [ "-s" "-w" "-X" "github.com/supabase/cli/cmd.version=1.45.1" ];
        ## });

      # ];
    };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        pkgs.nodejs_20
        pkgs.deno
        pkgs.nodePackages.typescript
        pkgs.nodePackages.pnpm
        pkgs.nodePackages.npm
        pkgs.supabase-cli
        pkgs.shopify-cli
      ];
    };
  };
}
