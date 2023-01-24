{
  programs.alacritty.enable = true;

  programs.alacritty.settings = {
    font = {
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
    selection = {
      semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
      save_to_clipboard = false;
    };
    cursor = {
      style.shape = "Beam";
      style.blinking = "Always";
      blink_interval = 500;
      thickness = 0.1;
    };
    window = {
      dynamic_padding = true;
      decorations = "none";
      startup_mode = "Maximized";
      opacity = 0.70;
    };
  };
}
