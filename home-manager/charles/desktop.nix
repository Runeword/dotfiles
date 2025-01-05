{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
in
# waybarwithfont = pkgs.waybar.overrideAttrs (oldAttrs: {
#   nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.nerdfonts.override {
#   fonts = [ "DroidSansMono" ];
# }; ];
#   postInstall =
#     (oldAttrs.postInstall or "")
#     + ''
#       mkdir -p $out/share/fonts
#       ln -s ${customFont}/share/fonts/* $out/share/fonts/
#     '';
# });
{
  home.packages = with pkgs; [
    # fuzzel # App launcher

    # Viewers
    imv # Image viewer
    wev # Event viewer

    # Interface
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))

    nerd-fonts.droid-sans-mono

    hyprpanel
    hyprlock # Screen locker
    fnott # Notification daemon
    # deadd-notification-center

    # Hardware managers
    networkmanagerapplet # Network manager
    nwg-displays # Monitor manager
    impala # Wifi manager
    bluetuith # Bluetooth manager
    # pw-viz             # Pipewire graph editor

    # Controllers
    brillo # Brightness control
    playerctl # Media players control

    # Wallpaper
    waypaper # Wallpaper setter
    hyprpaper # Wallpaper backend

    # Screen capture
    # wl-screenrec         # Screen recorder
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Screenshot
    grim # Grimblast dependency
    satty # Screenshot annotation
    slurp # Region selector
  ];
}
