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
      key = "shift-tab";
      internal = ":back";
    }
    {
      key = "tab";
      internal = ":focus";
    }
  ];

  # { key = "alt-enter"; internal = ":open_leave"; }
  # { key = "alt-enter"; internal = ":open_stay"; }
  # { key = "alt-enter"; internal = ":focus"; }
  # { invocation = "p"; execution = ":parent"; }
  # { invocation = "edit"; shortcut = "e"; execution = "$EDITOR {file}" ; }
  # { invocation = "create {subpath}"; execution = "$EDITOR {directory}/{subpath}"; }
  # { invocation = "view"; execution = "less {file}"; }
  # {
  #   invocation = "blop {name}\\.{type}";
  #   execution = "mkdir {parent}/{type} && ${pkgs.neovim}/bin/nvim {parent}/{type}/{name}.{type}";
  #   from_shell = true;
  # }
}
