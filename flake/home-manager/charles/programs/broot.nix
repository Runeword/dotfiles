{
  programs.broot.enable = true;
  programs.broot.enableBashIntegration = true;

  programs.broot.settings.verbs = [
    {
      key = "enter";
      external = "cd {directory}";
      from_shell = true;
    }
    {
      key = "tab";
      cmd = ":toggle_stage;:line_down";
    }
    {
      key = "Backtab";
      cmd = ":toggle_stage;:line_up";
    }
    {
      key = "ctrl-l";
      internal = ":clear_stage";
    }
    {
      key = "down";
      internal = ":line_down";
    }
    {
      key = "up";
      internal = ":line_up";
    }
    {
      key = "ctrl-u";
      internal = ":input_clear";
    }
    {
      key = "ctrl-left";
      internal = ":input_go_word_left";
    }
    {
      key = "ctrl-right";
      internal = ":input_go_word_right";
    }
    {
      key = "ctrl-h";
      internal = ":toggle_hidden";
    }
    {
      key = "ctrl-x";
      internal = ":toggle_perm";
    }
    {
      key = "ctrl-d";
      internal = ":toggle_dates";
    }
    {
      key = "ctrl-p";
      internal = ":toggle_preview";
    }
  ];
}
