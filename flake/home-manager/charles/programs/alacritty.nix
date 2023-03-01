{
  programs.alacritty.enable = true;

  programs.alacritty.settings.font = {
    normal.family = "Hack Nerd Font";
    normal.style = "Regular";
    bold.family = "Hack Nerd Font";
    bold.style = "Bold";
    italic.family = "Hack Nerd Font";
    italic.style = "Italic";
    bold_italic.family = "Hack Nerd Font";
    bold_italic.style = "Bold Italic";
    size = 10.0;
    offset.y = 5;
  };

  programs.alacritty.settings.selection = {
    semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
    save_to_clipboard = false;
  };

  programs.alacritty.settings.cursor = {
    style.shape = "Beam";
    style.blinking = "Always";
    blink_interval = 500;
    thickness = 0.1;
  };

  programs.alacritty.settings.window = {
    dynamic_padding = true;
    decorations = "none";
    startup_mode = "Maximized";
    opacity = 0.70;
  };

  programs.alacritty.settings.key_bindings = [
  { key = "PageUp"; mods = "Control|Shift"; command = { program = "tmux"; args = ["swap-window" "-t-1" ";" "select-window" "-t-1"]; }; }
  { key = "PageDown"; mods = "Control|Shift"; command = { program = "tmux"; args = ["swap-window" "-t+1" ";" "select-window" "-t+1"]; }; }
  { key = "PageUp"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t-1"]; }; }
  { key = "PageDown"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t+1"]; }; }
  { key = "Tab"; mods = "Control|Shift"; command = { program = "tmux"; args = ["select-window" "-t-1"]; }; }
  { key = "Tab"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t+1"]; }; }
  { key = "Key9"; mods = "Control"; command = { program = "tmux"; args = ["switch-client" "-p"]; }; }
  { key = "Key0"; mods = "Control"; command = { program = "tmux"; args = ["switch-client" "-n"]; }; }
  { key = "Key1"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t1"]; }; }
  { key = "Key2"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t2"]; }; }
  { key = "Key3"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t3"]; }; }
  { key = "Key4"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t4"]; }; }
  { key = "Key5"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t5"]; }; }
  { key = "Key6"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t6"]; }; }
  { key = "Key7"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t7"]; }; }
  { key = "Key8"; mods = "Control"; command = { program = "tmux"; args = ["select-window" "-t8"]; }; }
  ];

  programs.alacritty.settings.colors = {
    primary = {
      background = "#000000";
      foreground = "#ffffff";
    };

    normal = {
      black = "#000000";
      red = "#cd0000";
      green = "#00cd00";
      yellow = "#cdcd00";
      blue = "#0000ee";
      magenta = "#cd00cd";
      cyan = "#00cdcd";
      white = "#e5e5e5";
    };

    bright = {
      black = "#7f7f7f";
      red = "#ff0000";
      green = "#00ff00";
      yellow = "#ffff00";
      blue = "#5c5cff";
      magenta = "#ff00ff";
      cyan = "#00ffff";
      white = "#ffffff";
    };
  };
}
