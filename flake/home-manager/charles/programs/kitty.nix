{
  programs.kitty.enable = true;

  programs.kitty.settings = {
    background_opacity = "0.7";
    font_size = 20;
    cursor = "#ffffff";
    cursor_shape = "beam";
    cursor_beam_thickness = "0.1";
    cursor_blink_interval = "0.5";
    modify_font = "cell_height +5px";
  };

  programs.kitty.keybindings = {
    "ctrl+kp_plus" = "change_font_size all +2.0";
    "ctrl+kp_minus" = "change_font_size all -2.0";
    "ctrl+kp_equal" = "change_font_size all 0";
  };
}
