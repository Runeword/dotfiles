{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    htop
    unzip
    nurl
    nix-init
    qmk
    erdtree
    wluma
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
    rofi
    peek
    tree
    gcc
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    # xclip # X11
    # colorpicker # X11
    realesrgan-ncnn-vulkan
    slack
    bitwarden-cli
    google-chrome
    firefox
    neovim-nightly
    python311
    hyprpaper
    hyprpicker
    wl-clipboard
    imv

    (nerdfonts.override {fonts = ["Hack" "DroidSansMono" "SourceCodePro"];})

    inputs.src-cli.packages.x86_64-linux.default
    inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia
  ];
}
