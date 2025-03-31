# All package definitions
{ pkgs, lib }:

rec {
  environment = with pkgs; [
    cowsay
    yazi # file manager
    navi # cheat sheet
    starship # prompt
    wl-clipboard # copy/paste
    xdragon # drag and drop
    ueberzugpp # images support for terminal

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
    lsof

    # Development
    atac
    ngrok
    awscli2

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

    # Nix
    nix-init
    cachix

    # Multimedia
    asciinema # Terminal recorder
    lux # Video downloader
    qrcp # mobile QR files transfer

    # Disk
    ncdu
    qdirstat # Disk usage viewer
    erdtree # Disk usage
    nvme-cli # NVMe storage devices manager

    # Custom packages
    (import ./leader.nix { inherit pkgs; })
    (import ./tmux.nix {
      inherit pkgs;
      inherit (lib) mkOutOfStoreSymlink;
    })
  ];

  # Custom alacritty with additional packages and configuration
  alacritty = import ./alacritty.nix {
    inherit pkgs;
    inherit (lib) mkOutOfStoreSymlink;
    extraPackages = environment;
  };
}
