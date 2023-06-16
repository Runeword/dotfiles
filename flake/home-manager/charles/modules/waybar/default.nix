{pkgs, ...}: {
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      margin = "0 10 0 0";
      layer = "top";
      position = "left";
      output = ["eDP-1" "HDMI-A-1"];
      spacing = 0;
      exclusive = true;
      fixed-center = true;
      passthrough = false;
      gtk-layer-shell = true;
      ipc = false;
      modules-left = ["tray"];
      modules-center = ["wlr/workspaces" "wlr/taskbar"];
      modules-right = ["memory" "cpu"];

      tray = {
        icon-size = 30;
        spacing = 0;
      };

      "wlr/taskbar" = {
        all-outputs = true;
        spacing = 0;
        format = "{icon}";
        icon-theme = "Numix-Circle";
        icon-size = 30;
        markup = false;
        tooltip = false;
        active-first = false;
        on-click = "activate";
        on-click-middle = "close";
      };

      "wlr/workspaces" = {
        format = "{name}";
        on-click = "activate";
        sort-by-number = true;
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
      };

      memory = {
        interval = 2;
        tooltip = false;
        format = "{percentage}";
      };

      cpu = {
        interval = 2;
        tooltip = false;
        format = "{usage}";
        # "format"= "<span size='xx-large'> </span>\n<span size='x-large'>{usage}</span>";
      };
    };
  };

  programs.waybar.style = builtins.readFile ./style.css;
}
