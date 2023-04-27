{
  config,
  pkgs,
  lib,
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
    wget
    doppler
    ripgrep
    progress
    fd
    inkscape
    vifm
    xclip
    chezmoi
    trashy
    bat
    rofi
    peek
    gcc
    colorpicker
    realesrgan-ncnn-vulkan
    slack
    bitwarden-cli
    google-chrome
    firefox
    (nerdfonts.override {fonts = ["Hack" "DroidSansMono"];})
    neovim-nightly
    # python311
  ];

  home.sessionVariables = {
    # FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --follow --exclude .git";
    # FZF_CTRL_T_COMMAND="${config.home.sessionVariables.FZF_DEFAULT_COMMAND}";
    _ZO_FZF_OPTS = "--reverse --height 40% --no-separator --border none"; # zoxide fzf options
  };

  # home.sessionVariables = {
  #   FOO = "Hello";
  #   BAR = "${config.home.sessionVariables.FOO} World!";
  # };

  nixpkgs.overlays = [
  ];
}
