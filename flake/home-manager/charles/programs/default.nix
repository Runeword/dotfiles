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
    # ./xmonad.nix
    # ./wezterm.nix
  ];

  programs = {
    home-manager.enable = true;

    fzf.enable = true;
    fzf.enableBashIntegration = true;
    fzf.enableFishIntegration = true;
    fzf.defaultCommand = "fd --hidden --follow --no-ignore --exclude .git --exclude node_modules"; # --strip-cwd-prefix
    # fzf.defaultOptions = [ "--reverse" "--height 40%" "--no-separator" "--border none" "--bind tab:down" "--bind shift-tab:up" "--bind ctrl-space:select"];
    fzf.defaultOptions = ["--reverse" "--no-separator" "--border none"];
    fzf.fileWidgetCommand = config.programs.fzf.defaultCommand;
    # fzf.fileWidgetOptions = config.programs.fzf.defaultOptions;

    bash.enable = true;
    bash.enableCompletion = true;
    bash.bashrcExtra = builtins.readFile ../extra/.bashrc;

    fish.enable = true;
    fish.shellAbbrs = config.home.shellAliases;

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
