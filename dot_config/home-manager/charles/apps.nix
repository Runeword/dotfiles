{
  pkgs,
  # inputs,
  # lib,
  # config,
  ...
}:
let
  # https://issues.chromium.org/issues/397720842
  # pkgs-pin-google-chrome =
  #   import
  #     (builtins.fetchTarball {
  #       url = "https://github.com/NixOS/nixpkgs/archive/6c5c5f5100281f8f4ff23f13edd17d645178c87c.tar.gz";
  #       sha256 = "sha256:0wadw34slm7qh4ig3snwkls2sgkyz1yl5x9wqdzvyr8254arlspx";
  #     })
  #     {
  #       config.allowUnfree = true;
  #       system = pkgs.system;
  #     };
in
{
  home.packages = with pkgs; [
    # ---------------------------------- Editors
    vscode
    windsurf
    code-cursor
    android-studio
    figma-linux
    pgmodeler
    obsidian
    postman

    # ---------------------------------- Browsers
    # pkgs-pin-google-chrome.google-chrome
    google-chrome
    firefox
    tor-browser

    # ---------------------------------- Media
    vlc
    mpv
    kooha

    # ---------------------------------- Viewer
    libreoffice
    kdePackages.okular
    sioyek # PDF viewer
    fstl # .stl file viewer
    # mpvScripts.uosc

    # ---------------------------------- Graphic
    inkscape
    krita
    # obs-studio
    # davinci-resolve
    # realesrgan-ncnn-vulkan
    # inputs.nixified-ai.packages.x86_64-linux.invokeai-nvidia
    # inputs.nixified-ai.packages.x86_64-linux.koboldai-nvidia
  ];
}
