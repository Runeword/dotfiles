{ config, pkgs, lib, ... }: {
  xsession.windowManager.i3.enable = true;

  xsession.windowManager.i3.config = {
    modifier = "Mod4";
    floating.modifier = "Mod4";
    terminal = "alacritty";
    window.hideEdgeBorders = "smart";
    focus.newWindow = "focus";

    startup = [
      { command = "feh --bg-fill ~/.config/Skin\\ The\\ Remixes.png"; always = false; notification = false; }
    ];

    fonts = {
      names = [ "Noto Sans Regular" ];
      size = 16.0;
    };

    bars = [{
      position = "top";
      command = "i3bar --transparency";
      trayOutput = "primary";
      extraConfig = ''
      tray_padding 6px
      workspace_min_width 30
      strip_workspace_numbers yes
      '';

      fonts = {
        names = [ "Noto Sans Regular" ];
        size = 16.0;
      };

      colors.background = "#00000000";

      colors.focusedWorkspace = {
        background = "#00000000";
        border = "#00000000";
        text = "#ffffff";
      };

      colors.inactiveWorkspace = {
        background = "#00000000";
        border = "#00000000";
        text = "#7a7c9e";
      };

      colors.urgentWorkspace = {
        background = "#00000000";
        border = "#5294E2";
        text = "#ffffff";
      };
    }];

    assigns = {
      "1" = [{ class = "Alacritty"; }];
      "2" = [{ class = "Google-chrome"; }];
      "4" = [{ class = "Slack"; }];
    };

    keybindings =
    let
      mod = config.xsession.windowManager.i3.config.modifier;
    in {
      # Keybindings
      "${mod}+q" = "kill";
      "${mod}+space" = "floating toggle";
      "${mod}+u" = "exec warpd --grid";

      # Focus workspace
      "${mod}+1" = "workspace 1";
      "${mod}+2" = "workspace 2";
      "${mod}+3" = "workspace 3";
      "${mod}+4" = "workspace 4";
      "${mod}+5" = "workspace 5";
      "${mod}+6" = "workspace 6";
      "${mod}+7" = "workspace 7";
      "${mod}+8" = "workspace 8";
      "${mod}+9" = "workspace 9";

      # Applications
      "${mod}+h" = "exec (i3-msg [class=\"Alacritty\"] focus | grep true) || exec alacritty";
      "${mod}+t" = "exec (i3-msg [class=\"Google-chrome\"] focus | grep true) || exec google-chrome-stable";
      "${mod}+n" = "exec (i3-msg [class=\"Thunar\"] focus | grep true) || exec thunar";
      "${mod}+s" = "exec (i3-msg [class=\"Slack\"] focus | grep true) || exec slack";
      "${mod}+d" = "exec rofi -modi drun -show drun"; # -config ~/.config/rofi/rofidmenu.rasi

      # Multimedia
      # "${mod}+XF86AudioNext" = "exec playerctl position 5+";
      # "${mod}+XF86AudioPrev" = "exec playerctl position 5-";
      # "XF86AudioPlay" = "exec playerctl play-pause";
      # "XF86AudioNext" = "exec playerctl next";
      # "XF86AudioPrev" = "exec playerctl previous";
      # "XF86MonBrightnessUp" = "exec xbacklight +1";
      # "XF86MonBrightnessDown" = "exec xbacklight -1";
      # "XF86AudioRaiseVolume" = "exec amixer -D pulse sset Master 5%+";
      # "XF86AudioLowerVolume" = "exec amixer -D pulse sset Master 5%-";
      # "XF86AudioMute" = "exec amixer -D pulse sset Master toggle";
    };
  };

  xsession.windowManager.i3.extraConfig = ''
  for_window [class=.*] border pixel 6, focus
  '';
}
