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
        leader = pkgs.stdenv.mkDerivation {
          pname = "leader";
          version = "0.3.2";
          src = pkgs.fetchurl {
            url = "https://github.com/dhamidi/leader/releases/download/v0.3.2/leader.linux.amd64";
            sha256 = "sha256-lwOChHRvDvOm371v5xZUXS//6Dgn4CljioMrIBbWgwY=";
          };

          dontUnpack = true;

          installPhase = ''
            mkdir -p $out/bin
            cp $src $out/bin/leader
            chmod +x $out/bin/leader
          '';
        };

        pkgs = nixpkgs.legacyPackages.${system};

        additionalPackages = with pkgs; [
          cowsay
          yazi       # file manager
          leader     # leader key
          navi       # cheat sheet
          git        # versioning
          zsh-forgit # fuzzy git
          starship   # prompt
          wl-clipboard          # Copy/paste
          xdragon               # Drag and drop
          ueberzugpp            # Images support for terminal
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
