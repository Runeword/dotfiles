{
  pkgs,
  inputs,
  # lib,
  # config,
  ...
}:
# let
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
# in
{
  home.packages = with pkgs; [
    # Viewers
    imv # Image viewer
    wev # Event viewer

    # Interface
    # (waybar.overrideAttrs (oldAttrs: {
    #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    # }))
    waybar

    nerd-fonts.droid-sans-mono

    showmethekey
    appimage-run
    hyprpicker # Color picker

    hyprpanel
    hyprlock # Screen locker
    fnott # Notification daemon
    # deadd-notification-center

    # Hardware managers
    nwg-displays # Monitor manager
    impala # Wifi manager
    bluetuith # Bluetooth manager

    # Controllers
    brillo # Brightness control
    playerctl # Media players control
    iwgtk # Network manager

    # Wallpaper
    waypaper # Wallpaper setter
    hyprpaper # Wallpaper backend

    # Screen capture
    # wl-screenrec # Screen recorder
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Screenshot
    grim # Grimblast dependency
    satty # Screenshot annotation
    slurp # Region selector
  ];
}
