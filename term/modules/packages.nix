# Package lists for the environment
{ pkgs, customTmux }:

{
  extraPackages = with pkgs; [
    # Custom packages
    customTmux

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

    #_______________________________ Coreutils
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

    #_______________________________ Monitoring
    htop
    btop
    procs
    gping
    hyperfine # benchmarking

    #_______________________________ Archivers
    ouch
    xarchiver
    unzip

    #_______________________________ Versioning
    lazygit
    git-graph
    git # versioning
    zsh-forgit # fuzzy git

    #_______________________________ Containers
    lazydocker
    docker-compose
    distrobox
    terraform

    #_______________________________ Files
    miller # cvs toolbox
    glow # markdown

    #_______________________________ Info
    hwinfo # Hardware info
    onefetch # Git info
    neofetch # System info

    # zip
    # p7zip
    # gh
    # lazygit
    # gitui
    # inputs.src-cli.packages.x86_64-linux.default
  ];

  extraFonts = [
    pkgs.nerd-fonts.sauce-code-pro
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.caskaydia-mono
  ];
}

