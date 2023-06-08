{ config, pkgs, lib, ... }: {
  xsession.windowManager.i3.enable = true;
  programs.i3status.enable = true;
  programs.i3status.enableDefault = false;

  xsession.windowManager.i3.config = {
    modifier = "Mod4";
    floating.modifier = "Mod4";
    terminal = "kitty";
    window.hideEdgeBorders = "smart";
    focus.newWindow = "focus";

    fonts = {
      names = [ "DroidSansMono Nerd Font" ];
      size = 15.0;
    };

    startup = [
      { command = "feh --bg-fill ~/.config/SkinTheRemixes.png"; always = false; notification = false; }
    ];

    assigns = {
      "1" = [{ class = "kitty"; }];
      "2" = [{ class = "Google-chrome"; }];
      "4" = [{ class = "Slack"; }];
    };

  };

  xsession.windowManager.i3.config.colors = {
    focused = {
      background = "#00000000";
      border = "#00000000";
      indicator = "#e345ff";
      childBorder = "#ff0073";
      text = "#ffffff";
    };

    unfocused = {
      background = "#00000000";
      border = "#00000000";
      indicator = "#e345ff";
      childBorder = "#00000000";
      text = "#ffffff";
    };

    focusedInactive = {
      background = "#00000000";
      border = "#00000000";
      indicator = "#e345ff";
      childBorder = "#00000000";
      text = "#ffffff";
    };

    urgent = {
      background = "#00000000";
      border = "#00000000";
      indicator = "#e345ff";
      childBorder = "#00000000";
      text = "#ffffff";
    };
  };

  xsession.windowManager.i3.config.keybindings =
  let
    mod = config.xsession.windowManager.i3.config.modifier;
  in {
    "${mod}+r" = "reload";
    "${mod}+q" = "kill";
    "${mod}+space" = "floating toggle";

    # Focus window
    "${mod}+Right" = "focus right";
    "${mod}+Left" = "focus left";
    "${mod}+Up" = "focus up";
    "${mod}+Down" = "focus down";

    # Move window
    "${mod}+Shift+Right" = "move right";
    "${mod}+Shift+Left" = "move left";
    "${mod}+Shift+Up" = "move up";
    "${mod}+Shift+Down" = "move down";

    # Move window to workspace
    "${mod}+Shift+1" = "move container to workspace 1; workspace 1";
    "${mod}+Shift+2" = "move container to workspace 2; workspace 2";
    "${mod}+Shift+3" = "move container to workspace 3; workspace 3";
    "${mod}+Shift+4" = "move container to workspace 4; workspace 4";
    "${mod}+Shift+5" = "move container to workspace 5; workspace 5";
    "${mod}+Shift+6" = "move container to workspace 6; workspace 6";
    "${mod}+Shift+7" = "move container to workspace 7; workspace 7";
    "${mod}+Shift+8" = "move container to workspace 8; workspace 8";
    "${mod}+Shift+9" = "move container to workspace 9; workspace 9";

    # Focus workspace
    "${mod}+Tab" = "workspace next";
    "${mod}+Shift+Tab" = "workspace prev";
    "${mod}+1" = "workspace 1";
    "${mod}+2" = "workspace 2";
    "${mod}+3" = "workspace 3";
    "${mod}+4" = "workspace 4";
    "${mod}+5" = "workspace 5";
    "${mod}+6" = "workspace 6";
    "${mod}+7" = "workspace 7";
    "${mod}+8" = "workspace 8";
    "${mod}+9" = "workspace 9";


    # Run program
    # "${mod}+BackSpace" = "exec rofi -modi drun -show drun";
    # "${mod}+BackSpace" = "exec kitty bash -c 'fzf $* < /proc/$$/fd/0 > /proc/$$/fd/1'";
    "${mod}+BackSpace" = "exec ~/.config/rofi/launchers/type-3/launcher.sh";
    "${mod}+Shift+h" = "exec kitty";
    "${mod}+Shift+t" = "exec google-chrome-stable";
    "${mod}+Shift+n" = "exec thunar";

    # Focus or run program
    "${mod}+h" = "exec (i3-msg [class=\"kitty\"] focus | grep true) || exec kitty";
    "${mod}+t" = "exec (i3-msg [class=\"Google-chrome\"] focus | grep true) || exec google-chrome-stable";
    "${mod}+n" = "exec (i3-msg [class=\"Thunar\"] focus | grep true) || exec thunar";
    "${mod}+s" = "exec (i3-msg [class=\"Slack\"] focus | grep true) || exec slack";
  };

  xsession.windowManager.i3.config.bars = [{
    position = "top";
    command = "i3bar --transparency";
    statusCommand = "i3status";
    trayOutput = "primary";
    extraConfig = ''
    tray_padding 6px
    workspace_min_width 30
    strip_workspace_numbers yes
    '';

    fonts = {
      names = [ "DroidSansMono Nerd Font" ];
      size = 15.0;
    };

    colors = {
      background = "#00000000";

      focusedWorkspace = {
        background = "#00000000";
        border = "#00000000";
        text = "#ffffff";
      };

      inactiveWorkspace = {
        background = "#00000000";
        border = "#00000000";
        text = "#7a7c9e";
      };

      urgentWorkspace = {
        background = "#00000000";
        border = "#00000000";
        text = "#ffffff";
      };
    };
  }];

  xsession.windowManager.i3.extraConfig = ''
  # gaps inner 8px
  # smart_gaps on

  for_window [class=.*] border pixel 2, focus
  for_window [class="Pavucontrol" instance="pavucontrol"] floating enable
  for_window [class="Nm-connection-editor" instance="nm-connection-editor"] floating enable
  for_window [class="blueman-manager-wrapped" instance="blueman-manager-wrapped"] floating enable
  '';

  programs.i3status.general = {
    color_good = "#7a7c9e";
    color_degraded = "#5294e2";
    color_bad = "#5294e2";
    interval = 1;
  };

  programs.i3status.modules = {
    cpu_usage = {
      position = 1;
      settings = {
        format = "%usage";
        separator = false;
        separator_block_width = 40;
      };
    };

    memory = {
      position = 2;
      settings = {
        format = "%used";
        separator = false;
        separator_block_width = 40;
      };
    };

    "tztime hour" = {
      position = 3;
      settings = {
        format = "%H:%M";
        separator = false;
        separator_block_width = 40;
      };
    };

    "tztime day" = {
      position = 4;
      settings = {
        format = "%a%d-%m   ";
        separator = false;
        separator_block_width = 40;
      };
    };

    # "volume master" = {
    #   position = 5;
    #   settings = {
    #     format = "%volume 墳";
    #     format_muted = "婢 %volume ";
    #     device = "pulse";
    #     separator = false;
    #     separator_block_width = 40;
    #   };
    # };
  };
}
