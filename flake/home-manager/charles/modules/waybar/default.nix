{pkgs, ...}: {
  programs.waybar.enable = true;

  programs.waybar.settings.mainBar = {
    margin = "0 0 0 0";
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
    modules-right = ["clock#hour" "clock#day" "battery" "memory" "cpu"];
  };

  programs.waybar.settings.mainBar.tray = {
    icon-size = 30;
    spacing = 0;
  };

  programs.waybar.settings.mainBar."wlr/taskbar" = {
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

  programs.waybar.settings.mainBar."wlr/workspaces" = {
    format = "{name}";
    on-click = "activate";
    sort-by-number = true;
    on-scroll-up = "hyprctl dispatch workspace e+1";
    on-scroll-down = "hyprctl dispatch workspace e-1";
  };

  programs.waybar.settings.mainBar.memory = {
    interval = 2;
    tooltip = false;
    states = {
      warning = 70;
      critical = 90;
    };
    format = "<span size='x-large'></span>\n{percentage}";
  };

  programs.waybar.settings.mainBar.cpu = {
    interval = 2;
    tooltip = false;
    states = {
      warning = 70;
      critical = 90;
    };
    format = "<span size='x-large'></span>\n{usage}";
    # "format"= "<span size='xx-large'> </span>\n<span size='x-large'>{usage}</span>";
  };

  programs.waybar.settings.mainBar.battery = {
    interval = 30;
    states = {
      warning = 30;
      critical = 15;
    };
    format = "<span size='xx-large'>{icon}</span>\n{capacity}";
    format-icons = ["" "" "" "" ""];
  };

  programs.waybar.settings.mainBar.bluetooth = {
    format = "󰂯";
    format-disabled = "";
    format-connected = "󰂯";
    tooltip-format = "{controller_alias}\t{controller_address}";
    tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
  };

  programs.waybar.settings.mainBar."clock#hour" = {
    format = "{:%H\n%M}";
    format-alt = "{:%A, %B %d, %Y (%R)}";
    tooltip = false;
  };

  programs.waybar.settings.mainBar."clock#day" = {
    format = "{:%a\n%d\n%m}";
    tooltip = false;
  };

  programs.waybar.style = builtins.readFile ./style.css;
}
