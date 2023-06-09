{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/".device = "/dev/disk/by-uuid/febf3a5b-22df-4c5b-9a8f-2a52133e40dc";
  fileSystems."/".fsType = "ext4";

  boot.initrd.luks.devices."luks-e7b38457-61ac-441d-ab46-db469f456336".device = "/dev/disk/by-uuid/e7b38457-61ac-441d-ab46-db469f456336";

  fileSystems."/boot/efi".device = "/dev/disk/by-uuid/A7CB-42E9";
  fileSystems."/boot/efi".fsType = "vfat";

  swapDevices = [{device = "/dev/disk/by-uuid/35362b83-6c2d-4749-90e2-116c3f06f450";}];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  boot.kernelParams = [
    # For Power consumption
    # https://kvark.github.io/linux/framework/2021/10/17/framework-nixos.html
    "mem_sleep_default=deep"
    # For Power consumption
    # https://community.frame.work/t/linux-battery-life-tuning/6665/156
    "nvme.noacpi=1"
    # Workaround iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    "i915.enable_psr=1"
  ];

  # This enables the brightness and airplane mode keys to work
  # https://community.frame.work/t/12th-gen-not-sending-xf86monbrightnessup-down/20605/11
  boot.blacklistedKernelModules = ["hid-sensor-hub"];

  # Further tweak to ensure the brightness and airplane mode keys work
  # https://community.frame.work/t/responded-12th-gen-not-sending-xf86monbrightnessup-down/20605/67
  systemd.services.bind-keys-driver = {
    description = "Bind brightness and airplane mode keys to their driver";
    wantedBy = ["default.target"];
    after = ["network.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      ls -lad /sys/bus/i2c/devices/i2c-*:* /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-*:*
      if [ -e /sys/bus/i2c/devices/i2c-FRMW0001:00 -a ! -e /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-FRMW0001:00 ]; then
        echo fixing
        echo i2c-FRMW0001:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/bind
        ls -lad /sys/bus/i2c/devices/i2c-*:* /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-*:*
        echo done
      else
        echo no fix needed
      fi
    '';
  };

  # Alder Lake CPUs benefit from kernel 5.18 for ThreadDirector
  # https://www.tomshardware.com/news/intel-thread-director-coming-to-linux-5-18
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.18") (lib.mkDefault pkgs.linuxPackages_latest);

  # Fix TRRS headphones missing a mic
  # https://community.frame.work/t/headset-microphone-on-linux/12387/3
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=dell-headset-multi
  '';

  # For fingerprint support
  services.fprintd.enable = lib.mkDefault true;

  # Custom udev rules
  services.udev.extraRules = ''
    # Fix headphone noise when on powersave
    # https://community.frame.work/t/headphone-jack-intermittent-noise/5246/55
    SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0xa0e0", ATTR{power/control}="on"
    # Ethernet expansion card support
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8156", ATTR{power/autosuspend}="20"
  '';

  # Mis-detected by nixos-generate-config
  # https://github.com/NixOS/nixpkgs/issues/171093
  # https://wiki.archlinux.org/title/Framework_Laptop#Changing_the_brightness_of_the_monitor_does_not_work
  hardware.acpilight.enable = lib.mkDefault true;
}
