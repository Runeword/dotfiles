{ config, pkgs, inputs, ... }:

{
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  services.fwupd.enable = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  # environment.systemPackages = with pkgs; [
  environment.systemPackages = [
    # xfce.thunar-archive-plugin
    pkgs.xfce.xfce4-volumed-pulse
    pkgs.pavucontrol
    pkgs.pasystray
    pkgs.gnome.gnome-disk-utility
    # system-config-printer
    pkgs.gparted
    pkgs.vim
  ];

  services.udev.enable = true;
  services.udev.packages = with pkgs; [
    qmk-udev-rules
  ];

  # Bluetooth
  # services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # hardware.bluetooth.settings.General.Experimental = true;
  # hardware.bluetooth.settings.General.KernelExperimental = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets."/crypto_keyfile.bin" = null;

  # Enable swap on luks
  boot.initrd.luks.devices."luks-4609397c-29de-4fbc-88d8-e42b0736ec6e".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-4609397c-29de-4fbc-88d8-e42b0736ec6e".device = "/dev/disk/by-uuid/4609397c-29de-4fbc-88d8-e42b0736ec6e";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.ssh.startAgent = true;

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

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    # autoRepeatInterval = 150;
    # autoRepeatDelay = 25;

    # i3
    # displayManager.lightdm.enable = true;
    # displayManager.defaultSession = "none+i3";
    # desktopManager.xterm.enable = false;
    # windowManager.i3.enable = true;

    # # xfce
    # displayManager.defaultSession = "xfce";
    # desktopManager.xterm.enable = false;
    # desktopManager.xfce = {
    #   enable = true;
    # };

    # xfce + i3
    windowManager.i3.enable = true;
    displayManager.defaultSession = "xfce+i3";
    desktopManager.xterm.enable = false;
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };

    # # xfce + xmonad
    # desktopManager.xterm.enable = false;
    # desktopManager.xfce.enable = true;
    # desktopManager.xfce.noDesktop = true;
    # desktopManager.xfce.enableXfwm = false;
    # windowManager.xmonad.enable = true;
    # windowManager.xmonad.enableContribAndExtras = true;
    # windowManager.xmonad.extraPackages = haskellPackages : [
    #       haskellPackages.xmonad-contrib
    #       haskellPackages.xmonad-extras
    #       haskellPackages.xmonad
    #     ];
    # displayManager.defaultSession = "xfce+xmonad";

    };

  # printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;
  services.printing.drivers = [ pkgs.epson-escpr ];

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.charles = {
    isNormalUser = true;
    description = "charles";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [
    # ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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
