{
  description = "Alacritty with additional packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        additionalPackages = with pkgs; [
          cowsay
          yazi       # file manager
          leader     # leader key
          navi       # cheat sheet
          git        # versioning
          zsh-forgit # fuzzy git
          starship   # prompt
          #_______________________________ Coreutils
          bat
          zoxide
          gomi
          ripgrep
          fd
          fzf
          tree
          wget
          jq
          #_______________________________ Monitoring
          htop
          btop
          procs
          gping
          #_______________________________ Archivers
          ouch
          xarchiver
          unzip

          # zip
          # p7zip
          # gh
          # lazygit
          # gitui
          # inputs.src-cli.packages.x86_64-linux.default
        ];

        alacrittyWithPackages =
          pkgs.runCommand "alacritty-with-packages"
            {
              nativeBuildInputs = [ pkgs.makeWrapper ];
            }
            ''
              mkdir -p $out/bin
              makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
                --prefix PATH : ${pkgs.lib.makeBinPath additionalPackages}
            '';

      in
      {
        packages = {
          default = alacrittyWithPackages;
          runeword-alacritty = alacrittyWithPackages;
        };

        apps.default = {
          type = "app";
          program = "${alacrittyWithPackages}/bin/alacritty";
        };
      }
    );
}
