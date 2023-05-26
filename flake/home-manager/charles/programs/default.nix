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
    ./dircolors.nix
    # ./xmonad.nix
    # ./wezterm.nix
  ];

  programs = {
    home-manager.enable = true;

    bash.enable = true;
    bash.enableCompletion = true;
    bash.bashrcExtra = builtins.readFile ../extra/.bashrc;

    fish.enable = true;
    fish.shellAbbrs = config.home.shellAliases;
    fish.interactiveShellInit = "echo 'interactiveShellInit'";
    fish.loginShellInit = "echo 'loginShellInit'";
    fish.shellInit = builtins.readFile ../extra/config.fish;

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
