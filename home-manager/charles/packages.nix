{ pkgs
, inputs
, lib
, ...
}: {
  # }:
  # let

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

  # in
  # {

  home.file."bin/tmux/resurrect".source = "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect";
  home.file."bin/tmux/tmux-fzf".source = "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf";
  home.file."bin/fzf".source = "${pkgs.fzf}/share/fzf";
  home.file."bin/pinentry".source = "${pkgs.pinentry-curses}/bin/pinentry";

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" "VictorMono" "Monaspace" "CascadiaMono"]; })
    maple-mono-NF
    python311
    qmk
    gcc
    httrack
    # pgmodeler
    sioyek
    qdirstat
    testdisk-qt
    appimage-run

    # ---------------------------------- Editors
    # neovim-nightly
    inputs.neovim-runeword.packages.x86_64-linux.default
    kitty
    alacritty
    tmux
    tmuxPlugins.resurrect
    tmuxPlugins.tmux-fzf
    ueberzugpp
    nnn
    yazi
    fuzzel

    # tmuxKeylocker

    # ---------------------------------- Browsers
    google-chrome
    firefox
    tor-browser

    # ---------------------------------- Hardware
    networkmanagerapplet
    # pw-viz
    bluetuith
    brillo
    playerctl
    ventoy-full
    dmidecode
    libinput
    evtest

    # ---------------------------------- CLI tools
    jq
    git
    awscli2
    lsof
    lsd
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
    tldr
    navi
    asciinema
    terraform
    ngrok
    unzip
    lux
    exiftool
    watchexec
    meli
    extundelete
    # tealdeer
    # inputs.src-cli.packages.x86_64-linux.default

    # ---------------------------------- Git
    # inputs.src-cli.packages.x86_64-linux.default
    gh
    chezmoi
    zsh-forgit

    # ---------------------------------- Secrets
    bitwarden-cli
    doppler
    pass-wayland
    gnupg
    pinentry-curses
    # gpg-tui

    # ---------------------------------- Archivers
    # zip
    # unzip
    # p7zip
    ouch
    xarchiver

    # ---------------------------------- Analitics
    htop
    btop
    bottom
    procs
    duf
    gping
    tree
    erdtree
    progress
    hwinfo
    onefetch
    neofetch
    nvme-cli
    lynis
    # stacer

    # ---------------------------------- Graphics
    showmethekey
    inkscape
    # realesrgan-ncnn-vulkan
    kooha
    krita
    # obs-studio
    vlc
    mpv
    libsForQt5.okular
    # mpvScripts.uosc
    figma-linux
    fstl
    # davinci-resolve
    # inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia

    # ---------------------------------- Wayland
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))
    swaybg
    waypaper
    hyprpaper
    hyprlock
    hyprpicker
    wl-clipboard
    wev
    imv
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    satty
    fnott
    slurp
    grim
  ];
}
