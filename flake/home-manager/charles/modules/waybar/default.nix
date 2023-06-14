{pkgs, ...}: {
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      # margin = "5 20 5 20";
      margin = "20 2 20 2";
      layer = "top";
      position = "left";
      output = ["eDP-1" "HDMI-A-1"];
      spacing = 4;
      exclusive = true;
      fixed-center = true;
      passthrough = false;
      gtk-layer-shell = true;
      ipc = false;
      modules-left = ["tray"];
      modules-center = ["wlr/workspaces" "wlr/taskbar"];
      modules-right = ["temperature"];

      "wlr/taskbar" = {
        "format" = "{icon}";
        "icon-size" = 25;
        "spacing" = 70;
        "icon-theme" = "Numix-Circle";
        "tooltip-format" = "{title}";
        "on-click" = "activate";
        "on-click-middle" = "close";
      };

      "tray" = {
        "icon-size" = 25;
        "spacing" = 10;
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
      font-family: Source Code Pro;
      color: #ffffff;
    }
  '';
}
