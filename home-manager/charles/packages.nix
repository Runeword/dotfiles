{
  pkgs,
  inputs,
  # lib,
  ...
}: {
  # }: let

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

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Hack" "DroidSansMono" "SourceCodePro"];})
    python311
    qmk
    gcc
    httrack
    pgmodeler

    # ---------------------------------- Editors
    neovim-nightly
    vifm
    kitty

    # ---------------------------------- Browsers
    google-chrome
    firefox

    # ---------------------------------- Hardware
    networkmanagerapplet
    pw-viz
    bluetuith
    brillo

    # ---------------------------------- CLI tools
    starship
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

    # ---------------------------------- Git
    # inputs.src-cli.packages.x86_64-linux.default
    gh
    chezmoi

    # ---------------------------------- Secrets
    bitwarden-cli
    doppler

    # ---------------------------------- Archivers
    zip
    unzip
    xarchiver
    p7zip

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
    obs-studio
    # pkgs-old.obs-studio
    # obs-cli
    vlc
    # inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia

    # ---------------------------------- Wayland
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
