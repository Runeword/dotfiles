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
    # fuzzel # App launcher

    # Essential
    wl-clipboard         # Clipboard
    xdragon              # Drag and drop

    # Viewers
    imv                  # Image viewer
    wev                  # Event viewer

    # Interface
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; })) # Bar
    hyprlock             # Screen locker
    fnott                # Notification daemon

    # Hardware managers
    networkmanagerapplet # Network manager
    nwg-displays         # Monitor manager
    impala               # Wifi manager
    bluetuith            # Bluetooth manager
    # pw-viz             # Pipewire graph editor

    # Controllers
    brillo               # Brightness control
    playerctl            # Media players control

    # Wallpaper
    waypaper             # Wallpaper setter
    hyprpaper            # Wallpaper backend

    # Screen capture
    wl-screenrec         # Screen recorder
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Screenshot
    grim                 # Grimblast dependency
    satty                # Screenshot annotation
    slurp                # Region selector
  ];
}
