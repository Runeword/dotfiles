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

        tmuxWithPlugins = pkgs.tmux.overrideAttrs (oldAttrs: {
          nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
          buildInputs = oldAttrs.buildInputs ++ [
            pkgs.tmuxPlugins.vim-tmux-navigator
            pkgs.tmuxPlugins.resurrect
            pkgs.tmuxPlugins.continuum
          ];

          postInstall =
            (oldAttrs.postInstall or "")
            + ''
              wrapProgram $out/bin/tmux \
                --set TMUX_PLUGIN_MANAGER_PATH "$out/share/tmux-plugins" \
                --add-flags "-f $HOME/.config/tmux/tmux.conf"
            '';
        });

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

        extraPackages = with pkgs; [
          customPackages.leader # leader key
          cowsay # cowsay
          yazi # file manager
          navi # cheat sheet
          git # versioning
          zsh-forgit # fuzzy git
          starship # prompt
          wl-clipboard # Copy/paste
          xdragon # Drag and drop
          ueberzugpp # Images support for terminal
          tmuxWithPlugins

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

        extraFonts = [
          # maple-mono-NF
          (pkgs.nerdfonts.override {
            fonts = [
              "SourceCodePro"
              "Monaspace"
              "CascadiaMono"
              # "VictorMono"
            ];
          })
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
