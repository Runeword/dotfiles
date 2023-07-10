{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    htop
    unzip
    nix-init
    qmk
    erdtree
    brillo
    gh
    xarchiver
    xdragon
    wget
    doppler
    ripgrep
    progress
    neofetch
    onefetch
    fd
    inkscape
    vifm
    chezmoi
    trashy
    kooha
    tree
    gcc
    realesrgan-ncnn-vulkan
    slack
    bitwarden-cli
    google-chrome
    firefox
    neovim-nightly
    python311
    btop
    p7zip
    bluetuith
    gping

    # xfce.thunar
    # xfce.thunar-volman
    # xfce.thunar-archive-plugin
    # xfce.thunar-media-tags-plugin

    # Wayland
    hyprpaper
    hyprpicker
    wl-clipboard
    wev
    imv
    # grim
    # slurp
    swappy
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    # # X11
    # peek
    # xclip
    # colorpicker
    # xev

    (nerdfonts.override {fonts = ["Hack" "DroidSansMono" "SourceCodePro"];})

    inputs.src-cli.packages.x86_64-linux.default
    inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia
  ];
}
