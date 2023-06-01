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
    xclip
    chezmoi
    trashy
    rofi
    peek
    tree
    gcc
    colorpicker
    realesrgan-ncnn-vulkan
    slack
    bitwarden-cli
    google-chrome
    firefox
    neovim-nightly
    python311

    (nerdfonts.override {fonts = ["Hack" "DroidSansMono" "SourceCodePro"];})

    inputs.src-cli.packages.x86_64-linux.default
    inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia
  ];
}
