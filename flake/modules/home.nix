{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "charles";
  home.homeDirectory = "/home/charles";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    git
    htop
    wget
    ripgrep
    fd
    vifm
    xclip
    chezmoi
    bat
    gcc
    python311
    nodejs-19_x
    alacritty
    bitwarden-cli
    google-chrome
    neovim-nightly
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # home.shellAliases = import ./shellAliases.nix

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.fileWidgetCommand = "fd --hidden --follow --no-ignore --max-depth 1 --exclude .git --exclude node_modules";
  programs.fzf.defaultOptions = [ "--no-separator" ];

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
}
