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
}
