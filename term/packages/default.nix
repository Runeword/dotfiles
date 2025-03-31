# All package definitions
{ pkgs, lib }:

rec {
  # List of packages for the environment
  environment = with pkgs; [
    # Terminal tools
    cowsay
    yazi # file manager
    navi # cheat sheet
    starship # prompt
    wl-clipboard # copy/paste
    xdragon # drag and drop
    ueberzugpp # images support for terminal
    aider-chat # ai
    qrcp # mobile QR files transfer
    ngrok
    awscli2

    # Coreutils
    bat
    zoxide
    gomi
    ripgrep
    fd
    fzf
    tree
    wget
    jq
    sshs

    # Monitoring
    htop
    btop
    procs
    gping
    hyperfine # benchmarking

    # Archivers
    ouch
    xarchiver
    unzip

    # Versioning
    lazygit
    git-graph
    git # versioning
    zsh-forgit # fuzzy git

    # Containers
    lazydocker
    docker-compose
    distrobox
    terraform

    # Files
    miller # cvs toolbox
    glow # markdown

    # Info
    hwinfo # Hardware info
    onefetch # Git info
    neofetch # System info

    # Custom packages
    leader
    tmux
  ];

  # Fonts collection
  fonts = [
    pkgs.nerd-fonts.sauce-code-pro
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.caskaydia-mono
  ];

  # Custom leader package
  leader = import ./leader.nix { inherit pkgs; };

  # Custom tmux with configuration
  tmux = import ./tmux.nix {
    inherit pkgs;
    inherit (lib) mkOutOfStoreSymlink;
  };

  # Custom alacritty with additional packages and configuration
  alacritty = import ./alacritty.nix {
    inherit pkgs;
    inherit (lib) mkOutOfStoreSymlink;
    extraPackages = environment;
    extraFonts = fonts;
  };
}

