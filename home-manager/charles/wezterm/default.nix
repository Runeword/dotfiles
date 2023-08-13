{
  programs.wezterm.enable = true;

  programs.wezterm.colorSchemes = {
    default = {
      ansi = ["#000000" "#cd0000" "#00cd00" "#cdcd00" "#0000ee" "#cd00cd" "#00cdcd" "#e5e5e5"];
      bright = ["#7f7f7f" "#ff0000" "#00ff00" "#ffff00" "#5c5cff" "#ff00ff" "#00ffff" "#ffffff"];
      background = "#000000";
      foreground = "#ffffff";
      cursor_bg = "#ffffff";
      cursor_fg = "#ffffff";
      cursor_border = "#ffffff";
      selection_bg = "#ffffff";
      selection_fg = "#000000";
    };
  };

  programs.wezterm.extraConfig = builtins.readFile ../extra/wezterm.lua;
}
