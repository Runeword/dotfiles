{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux.enable = true;

  programs.tmux.terminal = "tmux-256color";
  programs.tmux.baseIndex = 1;
  programs.tmux.disableConfirmationPrompt = true;
  programs.tmux.escapeTime = 0;

  programs.tmux.extraConfig = ''
    # _________________________________ Extra options
    set -sa terminal-features ',alacritty:RGB'
    set -g mouse on
    set -g status-interval 1 # Update the status line every 1 seconds
    set -g renumber-windows on # Re-number windows when one is closed
    set -g display-time 500

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

    # _________________________________ Scripts
    run -b '/nix/store/n229j84913c7y76h5m4fa1g18gqmgn09-tmuxplugin-resurrect-unstable-2022-05-01/share/tmux-plugins/resurrect/scripts/restore.sh r'
  '';

  programs.tmux.plugins = [
    {plugin = pkgs.tmuxPlugins.resurrect;}
  ];

  home.shellAliases = {
    t = "tmux";
    tl = "tmux ls";
    ta = "tmux attach -t";
    td = "tmux detach";
    tnw = "tmux new-window -n";
    tkw = "tmux kill-window";
    trw = "read -p 'Window name: ' name && tmux rename-window $name";
    tns = "tmux new -s";
    tks = "tmux kill-session";
    trs = "read -p 'Session name: ' name && tmux rename-session $name";
    tkk = "tmux kill-server";
    tss = "/nix/store/n229j84913c7y76h5m4fa1g18gqmgn09-tmuxplugin-resurrect-unstable-2022-05-01/share/tmux-plugins/resurrect/scripts/save.sh";
    trr = "[[ '$TERM_PROGRAM' == 'tmux' ]] && /nix/store/n229j84913c7y76h5m4fa1g18gqmgn09-tmuxplugin-resurrect-unstable-2022-05-01/share/tmux-plugins/resurrect/scripts/restore.sh";
  };
}
