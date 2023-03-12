{ config, pkgs, lib, ... }: {
  programs.tmux.enable = true;

  programs.tmux.terminal = "tmux-256color";
  programs.tmux.baseIndex = 1;
  programs.tmux.disableConfirmationPrompt = true;
  programs.tmux.escapeTime = 0;

  programs.tmux.extraConfig = ''
  # _________________________________ Extra options
  set -g mouse on
  set -g status-interval 1 # Update the status line every 1 seconds
  set -g renumber-windows on # Re-number windows when one is closed

  # _________________________________ Status line
  set -g status-style bg=default
  set -g status-position top
  set -g status-left ""
  set -g status-right "#[fg=#ffffff]#S "
  set -g status-justify centre
  set -g window-status-current-format "#[fg=#ffffff]#W"
  set -g window-status-format "#[fg=#7a7c9e]#W"
  set -g window-status-separator "  "

  # _________________________________ Color sheme
  set -g mode-style "fg=#7a7c9e,bg=default,italics"
  set -g message-style "fg=#7a7c9e,bg=default"
  set -g message-command-style "fg=#7a7c9e,bg=default"
  set -g pane-border-style "fg=#2d324a"
  set -g pane-active-border-style "fg=#7a7c9e"

  # bind -n F3 run-shell -b "$CONFIG/tmux/plugins/tmux-fzf/scripts/window.sh switch"
  TMUX_FZF_PREVIEW=1
  '';

  programs.tmux.plugins = [
    { plugin = pkgs.tmuxPlugins.resurrect; }
    { plugin = pkgs.tmuxPlugins.tmux-fzf; }
  ];
}
