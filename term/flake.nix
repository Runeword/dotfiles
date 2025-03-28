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
        # pkgs = nixpkgs.legacyPackages.${system};
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        customPackages.leader = pkgs.stdenv.mkDerivation {
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

        # Custom tmux with configuration
        customTmux = pkgs.symlinkJoin {
          name = "tmux-with-config";
          paths = [ pkgs.tmux ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            mkdir -p $out/.config/tmux
            ln -s ${builtins.toString ./tmux/tmux.conf} $out/.config/tmux/tmux.conf
            wrapProgram $out/bin/tmux \
              --set XDG_CONFIG_HOME "$out/.config"
          '';
        };

        extraPackages = with pkgs; [
          customPackages.leader # leader key
          cowsay # cowsay
          yazi # file manager
          navi # cheat sheet
          customTmux # Custom tmux with configuration
          starship # prompt
          wl-clipboard # copy/paste
          xdragon # drag and drop
          ueberzugpp # images support for terminal
          aider-chat # ai
          qrcp # mobile QR files transfer
          ngrok
          awscli2

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
          sshs

          #_______________________________ Monitoring
          htop
          btop
          procs
          gping
          hyperfine # benchmarking

          #_______________________________ Archivers
          ouch
          xarchiver
          unzip

          #_______________________________ Versioning
          lazygit
          git-graph
          git # versioning
          zsh-forgit # fuzzy git

          #_______________________________ Containers
          lazydocker
          docker-compose
          distrobox
          terraform

          #_______________________________ Files
          miller # cvs toolbox
          glow # markdown

          #_______________________________ Info
          hwinfo # Hardware info
          onefetch # Git info
          neofetch # System info

          # zip
          # p7zip
          # gh
          # lazygit
          # gitui
          # inputs.src-cli.packages.x86_64-linux.default
        ];

        extraFonts = [
          # maple-mono-NF
          # (pkgs.nerdfonts.override {
          #   fonts = [
          #     "SourceCodePro"
          #     "Monaspace"
          #     "CascadiaMono"
          #     # "VictorMono"
          #   ];
          # })
          pkgs.nerd-fonts.sauce-code-pro
          pkgs.nerd-fonts.monaspace
          pkgs.nerd-fonts.caskaydia-mono
          # pkgs.nerd-fonts.victor-mono
        ];

        wrappedAlacritty =
          pkgs.runCommand "wrappedAlacritty"
            {
              nativeBuildInputs = [ pkgs.makeWrapper ];
            }
            ''
              mkdir -p $out/bin
              makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
                --prefix PATH : ${pkgs.lib.makeBinPath extraPackages} \
                --set FONTCONFIG_FILE ${pkgs.makeFontsConf { fontDirectories = extraFonts; }}
            '';

      in
      {
        packages = {
          default = wrappedAlacritty;
          wrappedAlacritty = wrappedAlacritty;
        };

        apps.default = {
          type = "app";
          program = "${wrappedAlacritty}/bin/alacritty";
        };
      }
    );
}
