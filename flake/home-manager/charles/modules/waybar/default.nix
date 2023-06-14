{pkgs, ...}: {
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      margin = "20 2 20 2";
      layer = "top";
      position = "left";
      output = ["eDP-1" "HDMI-A-1"];
      spacing = 20;
      exclusive = true;
      fixed-center = true;
      passthrough = false;
      gtk-layer-shell = true;
      ipc = false;
      modules-left = ["tray"];
      modules-center = ["wlr/workspaces" "wlr/taskbar"];
      modules-right = [];

      "tray" = {
        "icon-size" = 30;
        "spacing" = 10;
      };

      "wlr/taskbar" = {
        "format" = "{icon}";
        "icon-size" = 30;
        "icon-theme" = "Numix-Circle";
        "tooltip-format" = "{title}";
        "on-click-middle" = "close";
        "on-click" = "activate";
      };

      "wlr/workspaces" = {
        "format" = "{name}";
        "on-click" = "activate";
        "sort-by-number" = true;
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
      };
    };
  };

  programs.waybar.style = ''
    window#waybar {
      background-color: transparent;
    }
  '';
}
