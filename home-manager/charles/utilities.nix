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

    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))
    waypaper
    hyprpaper
    hyprlock
    hyprpicker
    wl-clipboard
    wev
    imv
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    satty
    fnott
    slurp
    grim
    nwg-displays
  ];
}
