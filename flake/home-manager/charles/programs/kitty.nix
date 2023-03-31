{
  programs.kitty.enable = true;

  programs.kitty.font = {
    name = "Hack Nerd Font";
    size = 20;
  };

  programs.kitty.settings = {
    cursor_shape = "beam";
    cursor_beam_thickness = "0.1";
    cursor_blink_interval = "0.5";
    modify_font = "cell_height +5px";
    clear_all_shortcuts = "yes";
    confirm_os_window_close = 0;
    # theme
    background_opacity = "0.7";
    background = "#000000";
    foreground = "#ffffff";
    cursor = "#ffffff";
    selection_background = "none";
    selection_foreground = "none";
    # normal
    color0  = "#000000";
    color1  = "#cd0000";
    color2  = "#00cd00";
    color3  = "#cdcd00";
    color4  = "#0000ee";
    color5  = "#cd00cd";
    color6  = "#00cdcd";
    color7  = "#e5e5e5";
    # bright
    color8 = "#7f7f7f";
    color9 = "#ff0000";
    color10 = "#00ff00";
    color11 = "#ffff00";
    color12 = "#5c5cff";
    color13 = "#ff00ff";
    color14 = "#00ffff";
    color15 = "#ffffff";
  };

  programs.kitty.keybindings = {
    "ctrl+kp_plus" = "change_font_size all +1.0";
    "ctrl+kp_minus" = "change_font_size all -1.0";
    "ctrl+kp_equal" = "change_font_size all 0";
    "ctrl+shift+c" = "copy_to_clipboard";
    "ctrl+shift+v" = "paste_from_clipboard";
    # tmux
    "ctrl+tab" = "launch --type background tmux select-window -t+1";
    "ctrl+shift+tab" = "launch --type background tmux select-window -t-1";
    "ctrl+page_down" = "launch --type background tmux select-window -t+1";
    "ctrl+page_up" = "launch --type background tmux select-window -t-1";
    "ctrl+shift+page_up" = "launch --type background tmux swap-window -t-1 ; select-window -t-1";
    "ctrl+shift+page_down" = "launch --type background tmux swap-window -t+1 ; select-window -t+1";
    "ctrl+9" = "launch --type background tmux switch-client -p";
    "ctrl+0" = "launch --type background tmux switch-client -n";
    "ctrl+1" = "launch --type background tmux select-window -t1";
    "ctrl+2" = "launch --type background tmux select-window -t2";
    "ctrl+3" = "launch --type background tmux select-window -t3";
    "ctrl+4" = "launch --type background tmux select-window -t4";
    "ctrl+5" = "launch --type background tmux select-window -t5";
    "ctrl+6" = "launch --type background tmux select-window -t6";
    "ctrl+7" = "launch --type background tmux select-window -t7";
    "ctrl+8" = "launch --type background tmux select-window -t8";
  };
}
