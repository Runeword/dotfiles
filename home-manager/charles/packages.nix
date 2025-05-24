{
  pkgs,
  inputs,
  lib,
  config,
  ...
# }: {
}:
# let
# termium = pkgs.stdenv.mkDerivation {
#   pname = "termium";
#   version = "0.2.1";
#   src = pkgs.fetchurl {
#     url = "https://github.com/Exafunction/codeium/releases/download/termium-v0.2.1/termium_x86_64-unknown-linux-gnu";
#     sha256 = "sha256-DZR+MSIJWkuiKjRtPqzwvj+hXhel71+5HPJ/7G1o+tw=";
#   };
#
#   dontUnpack = true;
#
#   installPhase = ''
#     mkdir -p $out/bin
#     cp $src $out/bin/termium
#     chmod +x $out/bin/termium
#   '';
# };

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

# windsurf = pkgs.callPackage ./windsurf.nix { };
# in
{
  # home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/neovim/config";
  # home.file.".config/zsh/plugins/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
  # home.file.".local/share/bash-completion/bash_completion".source = "${pkgs.bash-completion}/share/bash-completion/bash_completion";
  # home.file."${builtins.getEnv "XDG_DATA_HOME"}/bash-completion/bash_completion".source = "${pkgs.bash-completion}/share/bash-completion/bash_completion";
  # home.file."${config.home.sessionVariables.XDG_DATA_HOME}/fzf".source = "${pkgs.fzf}/share/fzf";
  # home.file."${config.home.sessionVariables.XDG_BIN_HOME}/pinentry".source = "${pkgs.pinentry-curses}/bin/pinentry";

  home.packages = with pkgs; [
    inputs.runeword-terminal.packages.x86_64-linux.default
    python311
    gcc

    git
    direnv
    nix-direnv
    ffuf

    # claude-code
    # rquickshare

    # Recovery
    testdisk-qt # GUI Recovery tool
    extundelete # Recover deleted files from an ext3 or ext4 partition
    foremost # Recover files based on their headers and footers
    exiftool # Meta information reader/writer
    onlyoffice-desktopeditors

    # bash-completion

    # ---------------------------------- Terminal
    # inputs.runeword-neovim.packages.x86_64-linux.dev
    (inputs.runeword-neovim.lib.mkNeovimConfig { flakeDir = "/home/charles/neovim"; }).packages.x86_64-linux.dev
    kitty # Terminal emulator

    # inputs.walker.packages.x86_64-linux.default

    # Secrets
    # doppler
    # bitwarden-cli
    # rbw
    bws
    infisical

    # Secrets
    pass-wayland
    gnupg
    pinentry-curses
    # gpg-tui
  ];
}
