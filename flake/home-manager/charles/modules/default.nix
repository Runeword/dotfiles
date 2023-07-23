{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
    ./starship.nix
    ./broot.nix
    ./zoxide.nix
    ./fzf.nix
    ./home.nix
    ./packages.nix
    ./git.nix
    ./bash
    ./bat
    ./sh
    ./zsh
    # ./eww
    # ./dircolors.nix
  ];

  # services.fnott.enable = true;
  # services.fnott.settings = {
  #   main = {
  #   min-width=0;
  #   max-width=500;
  #   max-height=300;
  #   stacking-order="bottom-up";
  #   anchor="top-right";
  #   icon-theme="hicolor";
  #   max-icon-size=32;
  #   edge-margin-vertical=10;
  #   edge-margin-horizontal=10;
  #   notification-margin=10;
  #   layer="top";
  #   background=3f5f3fff;
  #   border-color=909090ff;
  #   border-size=1;
  #   };



    # padding-vertical=20
    # padding-horizontal=20

    # dpi-aware=auto

    # title-font=sans serif
    # title-color=ffffffff
    # title-format=<i>%a%A</i>

    # summary-font=sans serif
    # summary-color=ffffffff
    # summary-format=<b>%s</b>\n

    # body-font=sans serif
    # body-color=ffffffff
    # body-format=%b

    # progress-bar-height=20
    # progress-bar-color=ffffffff

    # sound-file=
    # icon=

    # Timeout values are in seconds. 0 to disable
    # max-timeout=0
    # default-timeout=0
    # idle-timeout=0

    # [low]
    # background=2b2b2bff
    # title-color=888888ff
    # summary-color=888888ff
    # body-color=888888ff

    # [normal]

    # [critical]
    # background=6c3333ff
  # };

  programs = {
    home-manager.enable = true;

    vscode.enable = true;

    jq.enable = true;

    waybar.enable = true;
    waybar.package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });

    direnv.enable = true;
    direnv.enableBashIntegration = true;
    direnv.nix-direnv.enable = true;

    fuzzel.enable = true;

    zellij.enable = true;
  };
  # environment.pathsToLink = [ "/share/zsh" ];
}
