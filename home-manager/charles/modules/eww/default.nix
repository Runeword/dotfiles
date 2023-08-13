{pkgs, ...}: {
  programs.eww.enable = true;
  programs.eww.configDir = ./.;
  programs.eww.package = pkgs.eww-wayland;
}
