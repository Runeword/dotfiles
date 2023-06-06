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
    ./bat.nix
    ./packages.nix
    ./shellAliases.nix
    ./nushell.nix
    ./services.nix
    ./git.nix
    ./bash
    ./fish
    # ./dircolors.nix
  ];

  programs = {
    home-manager.enable = true;

    vscode.enable = true;

    jq.enable = true;

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    # navi.enable = true;
    # navi.enableBashIntegration = true;

    # skim.enable = true;
    # skim.enableBashIntegration = true;
  };
}
