{
  pkgs,
  inputs,
  ...
}: {
  nix.package = pkgs.nixFlakes;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  security.polkit.enable = true;
  services.fwupd.enable = true;

  services.xserver = {
    enable = true;
    # layout = "us";
    # xkbVariant = "altgr-intl";
    # videosDrivers = ["nvidia"];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    xwayland.hidpi = true;
    nvidiaPatches = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # xfce.xfce4-volumed-pulse
    # pasystray
    # pavucontrol
    # system-config-printer
    # gnome.gnome-disk-utility
    vim
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xarchiver
    gparted
  ];

  # thunar
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.udev.enable = true;
  services.udev.packages = with pkgs; [
    qmk-udev-rules
  ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  # services.clight.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;
  hardware.bluetooth.settings.General.KernelExperimental = true;
  # services.blueman.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  location.provider = "manual";
  location.longitude = 2.352222;
  location.latitude = 48.856613;

  # Setup keyfile
  boot.initrd.secrets."/crypto_keyfile.bin" = null;

  # Enable swap on luks
  boot.initrd.luks.devices."luks-4609397c-29de-4fbc-88d8-e42b0736ec6e".keyFile = "/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-4609397c-29de-4fbc-88d8-e42b0736ec6e".device = "/dev/disk/by-uuid/4609397c-29de-4fbc-88d8-e42b0736ec6e";

  # network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.ssh.startAgent = true;

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

  # services.xserver = {
  #   enable = true;
  #   layout = "us";
  #   xkbVariant = "altgr-intl";
  #   # autoRepeatInterval = 150;
  #   # autoRepeatDelay = 25;
  #
  #   # i3
  #   # displayManager.lightdm.enable = true;
  #   # displayManager.defaultSession = "none+i3";
  #   # desktopManager.xterm.enable = false;
  #   # windowManager.i3.enable = true;
  #
  #   # # xfce
  #   # displayManager.defaultSession = "xfce";
  #   # desktopManager.xterm.enable = false;
  #   # desktopManager.xfce = {
  #   #   enable = true;
  #   # };
  #
  #   # xfce + i3
  #   windowManager.i3.enable = true;
  #   displayManager.defaultSession = "xfce+i3";
  #   desktopManager.xterm.enable = false;
  #   desktopManager.xfce = {
  #     enable = true;
  #     noDesktop = true;
  #     enableXfwm = false;
  #   };

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

  # };

  # printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;
  services.printing.drivers = [pkgs.epson-escpr];

  # audio
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.wireplumber.enable = true;
  # services.pipewire.lowLatency.enable = true;
  # services.pipewire.pulse.enable = true;
  # services.pipewire.alsa.enable = true;
  # services.pipewire.alsa.support32Bit = true;
  # services.pipewire.jack.enable = true;

  # user
  users.users.charles = {
    isNormalUser = true;
    description = "charles";
    extraGroups = ["networkmanager" "wheel"];
    # packages = with pkgs; [
    # ];
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
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
