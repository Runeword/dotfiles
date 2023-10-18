{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # }: let

  # tmuxKeylocker = pkgs.tmuxPlugins.mkTmuxPlugin {
  #   pluginName = "tmux-keylocker";
  #   version = "1.0";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "TheSast";
  #     repo = "tmux-keylocker";
  #     rev = "c98dfd0956b458a8e71304f3532e8c3053df9555";
  #     sha256 = "sha256-AdVPL7tZxTJ05Q9b41ejCw/2kFNXrrsKkAIm8MAlbdw=";
  #     # sha256 = lib.fakeSha256;
  #   };
  # };

  # pkgs-old = import (builtins.fetchGit {
  #   # Descriptive name to make the store path easier to identify
  #   name = "pkgs-old";
  #   url = "https://github.com/NixOS/nixpkgs/";
  #   ref = "refs/heads/nixpkgs-unstable";
  #   rev = "3c3b3ab88a34ff8026fc69cb78febb9ec9aedb16";
  # }) {inherit (pkgs) system;};
  # pkgs-old = import (builtins.fetchTarball {
  #   url = "https://github.com/NixOS/nixpkgs/archive/2f04861c8ad1aaa69d532f34b63bb03da9912ae7.tar.gz";
  #   sha256 = "sha256:11dxbmxqcyw87fcyj2dm7d94wax2s1phajwp99rycwjikq3ks8s6";
  #   # sha256 = lib.fakeSha256;
  # }) {inherit (pkgs) system;};

  # in {

  home.file."bin/tmux/resurrect".source = "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect";
  home.file."bin/tmux/tmux-fzf".source = "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf";

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Hack" "DroidSansMono" "SourceCodePro"];})
    python311
    qmk
    gcc
    httrack
    pgmodeler
    sioyek

    # ---------------------------------- Editors
    neovim-nightly
    kitty
    alacritty
    tmux
    tmuxPlugins.resurrect
    tmuxPlugins.tmux-fzf

    # tmuxKeylocker

    # ---------------------------------- Browsers
    google-chrome
    firefox

    # ---------------------------------- Hardware
    networkmanagerapplet
    pw-viz
    bluetuith
    brillo
    playerctl

    # ---------------------------------- CLI tools
    awscli2
    lsof
    distrobox
    fzf
    starship
    zoxide
    bat
    hyperfine
    wl-screenrec
    wget
    ripgrep
    fd
    gomi
    xdragon
    nix-init
    # tealdeer
    tldr
    navi
    asciinema
    terraform
    ngrok
    distrobox

    # ---------------------------------- Git
    # inputs.src-cli.packages.x86_64-linux.default
    gh
    chezmoi

    # ---------------------------------- Secrets
    bitwarden-cli
    doppler

    # ---------------------------------- Archivers
    # zip
    # unzip
    # p7zip
    ouch
    xarchiver

    # ---------------------------------- Analitics
    htop
    btop
    duf
    gping
    tree
    erdtree
    neofetch
    onefetch
    progress

    # ---------------------------------- Graphics
    showmethekey
    inkscape
    realesrgan-ncnn-vulkan
    imaginer
    kooha
    # obs-studio
    vlc
    # davinci-resolve
    # inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia

    # ---------------------------------- Wayland
    swaybg
    waypaper
    hyprpaper
    hyprpicker
    wl-clipboard
    wev
    imv
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    swappy
    fnott
    slurp
    grim
  ];
}
