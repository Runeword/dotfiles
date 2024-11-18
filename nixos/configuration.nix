{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  # nix.package = pkgs.nixFlakes;
  nix.package = pkgs.nixVersions.latest;

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # nix.optimise.automatic = true;
  # nix.settings.auto-optimise-store = true;

  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 30d";
  # };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.settings.keep-outputs = true;
  nix.settings.keep-derivations = true;
  nix.settings.accept-flake-config = true;

  nix.settings.trusted-users = [
    "root"
    "charles"
  ];

  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

  security.sudo.enable = true;
  security.polkit.enable = true;

  services.fwupd.enable = true;

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "charles";
      };
      default_session = initial_session;
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

  virtualisation.podman.enable = true;
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

  nixpkgs.config.allowUnfree = true;

  # environment.etc."polkit-gnome-authentication-agent-1".source = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  environment.etc."polkit-kde-authentication-agent-1".source = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";

  systemd.tmpfiles.rules = [
    "L+ /usr/share/fzf - - - - ${pkgs.fzf}/share/fzf"
    "L+ /usr/bin/pinentry - - - - ${pkgs.pinentry-curses}/bin/pinentry"
  ];

  environment.systemPackages = with pkgs; [
    # xfce.xfce4-volumed-pulse
    # pasystray
    # pavucontrol
    # system-config-printer
    # gnome.gnome-disk-utility
    alsa-utils
    vim
    xarchiver
    # polkit_gnome
    libsForQt5.polkit-kde-agent
    exfatprogs
    gparted
    udisks
    udiskie
    jmtpfs
  ];

  # zsh
  programs.zsh.enable = true;
  users.users.charles.shell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  # thunar
  programs.thunar.enable = true;
  # programs.thunar.plugins = with pkgs.xfce; [
  # thunar-archive-plugin
  # thunar-media-tags-plugin
  # thunar-volman
  # ];
  # services.gvfs.enable = false; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # udev
  services.udev.enable = true;
  services.udev.packages = with pkgs; [
    qmk-udev-rules
    android-udev-rules
  ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  # services.clight.enable = true;

  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # hardware.bluetooth.settings.General.Experimental = true;
  # hardware.bluetooth.settings.General.KernelExperimental = true;
  # services.blueman.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  location.provider = "manual";
  location.longitude = 2.352222;
  location.latitude = 48.856613;

  xdg.mime.enable = lib.mkForce false;

  # Setup keyfile
  boot.initrd.secrets."/crypto_keyfile.bin" = null;

  # Enable swap on luks
  boot.initrd.luks.devices."luks-4609397c-29de-4fbc-88d8-e42b0736ec6e".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-4609397c-29de-4fbc-88d8-e42b0736ec6e".device = "/dev/disk/by-uuid/4609397c-29de-4fbc-88d8-e42b0736ec6e";

  # network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.ssh.startAgent = true;

  programs.nix-ld.enable = true;

  # locale
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  services.printing.drivers = [ pkgs.epson-escpr ];
  # pkgs.gutenprint pkgs.canon-cups-ufr2

  # audio
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.wireplumber.extraConfig = {
    "10-disable-camera" = {
      "wireplumber.profiles" = {
        main."monitor.libcamera" = "disabled";
      };
    };
  };

  services.pipewire.pulse.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;

  # services.pipewire.lowLatency.enable = true;
  # services.pipewire.jack.enable = true;

  # user
  users.users.charles = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # packages = with pkgs; [
    # ];
  };

  users.users.zod = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
