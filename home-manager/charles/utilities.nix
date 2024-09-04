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
    # pw-viz # Pipewire graph editor

    # Essentials
    wl-clipboard         # Clipboard
    xdragon              # Drag and drop

    # Terminal Tools
    hyprpicker           # Color picker
    wev                  # Event viewer
    imv                  # Image viewer
    wl-screenrec         # Screen recorder

    # Interface
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; })) # Bar
    hyprlock             # Screen locker
    fnott                # Notification daemon

    # Hardware manager/control
    networkmanagerapplet # Network manager
    nwg-displays         # Monitor manager
    impala               # Wifi manager
    bluetuith            # Bluetooth manager
    brillo               # Brightness control
    playerctl            # Media players control

    # Wallpaper
    waypaper             # Wallpaper setter
    hyprpaper            # Wallpaper backend

    # Screenshot
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Screenshot
    grim                 # Grimblast dependency
    satty                # Screenshot annotation
    slurp                # Region selector
  ];
}
