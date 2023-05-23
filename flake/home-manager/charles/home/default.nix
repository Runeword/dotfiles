{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [./shellAliases.nix];
  home.username = "charles";
  home.homeDirectory = "/home/charles";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    htop
    unzip
    nurl
    nix-init
    qmk
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
    gcc
    colorpicker
    realesrgan-ncnn-vulkan
    slack
    bitwarden-cli
    google-chrome
    firefox
    neovim-nightly
    # python311

    (nerdfonts.override {fonts = ["Hack" "DroidSansMono" "SourceCodePro"];})

    inputs.src-cli.packages.x86_64-linux.default
    inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia
  ];

  home.sessionVariables = {
    # FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --follow --exclude .git";
    # FZF_CTRL_T_COMMAND="${config.home.sessionVariables.FZF_DEFAULT_COMMAND}";
    # FZF_DEFAULT_OPTS="--bind tab:down shift-tab:up";
  };

  nixpkgs.overlays = [
  ];
}
