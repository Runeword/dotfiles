{ pkgs
, inputs
, lib
, config
, ...
  }:
  let
  in
  {
  home.packages = with pkgs; [
    # fuzzel
    networkmanagerapplet
    # # pw-viz
    # bluetuith
    # brillo
    # playerctl
    # impala # wifi
    # wl-screenrec
    # xdragon
    # showmethekey

    hyprpicker   # Color picker
    wev          # Event viewer
    imv          # Image viewer

    # Essentials
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))
    wl-clipboard # Clipboard
    hyprlock     # Screen locker
    fnott        # Notification daemon
    nwg-displays # Monitor manager

    # Wallpaper
    waypaper     # Wallpaper setter
    hyprpaper    # Wallpaper backend

    # Screenshot
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Screenshot
    grim         # Grimblast dependency
    satty        # Screenshot annotation
    slurp        # Region selector
  ];
}
