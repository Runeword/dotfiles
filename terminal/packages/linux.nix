{ pkgs, system }:

pkgs.lib.optionals (system == "x86_64-linux" || system == "aarch64-linux") (with pkgs; [
  wl-clipboard # copy/paste
  xdragon # drag and drop
  nvme-cli # NVMe storage devices manager
  hwinfo # hardware info
  evtest # input device testing
  libinput # input device handling
  ventoy-full # USB boot utility
  dmidecode
  cloneit
  xarchiver
  git-graph
  distrobox
])
