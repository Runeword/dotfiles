{ config, pkgs, lib, ... }: {
  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config = {
    modifier = "Mod4";
    floating.modifier = "Mod4";
    terminal = "alacritty";
    window.hideEdgeBorders = "smart";
    focus.newWindow = "focus";
    fonts = {
      names = [ "Noto Sans Regular" ];
      size = 20.0;
    };
    colors.focused = {
      background = "#00000000";
      border = "#00000000";
      childBorder = "#0080ff60";
      indicator = "#e345ff";
      text = "#ffffff";
    };
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
      "${mod}+h" = "exec (i4-msg [class=\"Alacritty\"] focus | grep true) || exec alacritty";
      "${mod}+t" = "exec (i3-msg [class=\"Google-chrome\"] focus | grep true) || exec google-chrome-stable";
      "${mod}+n" = "exec (i3-msg [class=\"Thunar\"] focus | grep true) || exec thunar";
      "${mod}+s" = "exec (i3-msg [class=\"Slack\"] focus | grep true) || exec slack";
    };
  };
  xsession.windowManager.i3.extraConfig = ''
  for_window [class=.*] border pixel 6, focus
  '';
}
