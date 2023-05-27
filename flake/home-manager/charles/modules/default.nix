{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./kitty.nix
    ./i3.nix
    ./feh.nix
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
    ./starship.nix
    ./broot.nix
    ./zoxide.nix
    ./fzf.nix
    ./home.nix
    ./shellAliases.nix
    ./bash
    ./fish
    # ./dircolors.nix
  ];

  programs = {
    home-manager.enable = true;

    git.enable = true;
    git.userEmail = "60324746+Runeword@users.noreply.github.com";
    git.userName = "Runeword";
    # git.delta.enable = true;

    vscode.enable = true;

    jq.enable = true;

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    bat.enable = true;
    bat.config.theme = "Nord";

    # navi.enable = true;
    # navi.enableBashIntegration = true;

    # skim.enable = true;
    # skim.enableBashIntegration = true;
  };
}
