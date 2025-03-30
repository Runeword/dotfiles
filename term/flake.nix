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

        mkOutOfStoreSymlink =
          path:
          let
            fileName = builtins.baseNameOf path;
          in
          "${
            pkgs.runCommandLocal "out-of-store-symlink-${fileName}"
              {
                allowSubstitutes = false;
                preferLocalBuild = true;
              }
              ''
                mkdir -p $out
                ln -s ${toString /home/charles/term}${pkgs.lib.removePrefix (toString ./.) (toString path)} $out/${fileName}
              ''
          }/${fileName}";

        customTmux = pkgs.symlinkJoin {
          name = "tmux-with-config";
          paths = [ pkgs.tmux ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            mkdir -p $out/.config/tmux/plugins

            ln -sf ${mkOutOfStoreSymlink (toString ./tmux/tmux.conf)} $out/.config/tmux/tmux.conf

            ln -s ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/.config/tmux/plugins/resurrect
            ln -s ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf $out/.config/tmux/plugins/tmux-fzf

            wrapProgram $out/bin/tmux \
              --set XDG_CONFIG_HOME "$out/.config"
          '';
        };

        extraPackages = with pkgs; [
          customPackages.leader # leader key
          cowsay # cowsay
          yazi # file manager
          navi # cheat sheet
          customTmux
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
          pkgs.nerd-fonts.sauce-code-pro
          pkgs.nerd-fonts.monaspace
          pkgs.nerd-fonts.caskaydia-mono
        ];

        customAlacritty =
          pkgs.runCommand "alacritty"
            {
              nativeBuildInputs = [ pkgs.makeWrapper ];
            }
            ''
              mkdir -p $out/bin
              mkdir -p $out/.config/alacritty

              ln -sf ${mkOutOfStoreSymlink (toString ./alacritty/alacritty.toml)} $out/.config/alacritty/alacritty.toml

              makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
                --prefix PATH : ${pkgs.lib.makeBinPath extraPackages} \
                --set FONTCONFIG_FILE ${pkgs.makeFontsConf { fontDirectories = extraFonts; }} \
                --set XDG_CONFIG_HOME "$out/.config"
            '';

      in
      {
        packages = {
          default = customAlacritty;
          customAlacritty = customAlacritty;
          customTmux = customTmux;
        };

        apps = {
          default = {
            type = "app";
            program = "${customAlacritty}/bin/alacritty";
          };
          customTmux = {
            type = "app";
            program = "${customTmux}/bin/tmux";
          };
        };
      }
    );
}
