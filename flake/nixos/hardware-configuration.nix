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
}
