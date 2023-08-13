{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.broot.enable = true;
  programs.broot.enableBashIntegration = true;
  programs.broot.enableFishIntegration = true;

  programs.broot.settings = {
    content_search_max_file_size = "10MB";
    modal = false;
    quit_on_last_cancel = true;
    show_selection_mark = true;
    imports = lib.mkForce [];
    syntax_theme = "MochaDark"; # Github SolarizedDark SolarizedLight MochaDark OceanDark OceanLight
  };

  programs.broot.settings.verbs = [
    {
      key = "enter";
      external = ''
        if [ -d {file} ]
        then cd {file}
        else $EDITOR {file}
        fi
      '';
      from_shell = true;
      leave_broot = true;
    }

    {
      key = "ctrl-d";
      external = "dragon -x {file}";
      leave_broot = false;
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
      key = "ctrl-i";
      cmd = ":toggle_hidden;:toggle_perm;:toggle_dates";
    }

    {
      key = "ctrl-p";
      internal = ":toggle_preview";
    }

    # # Example 1: launching `tail -n` on the selected file (leaving broot)
    # # {
    # #     name: tail_lines
    # #     invocation: tl {lines_count}
    # #     execution: "tail -f -n {lines_count} {file}"
    # # }
    #
    # # Example 2: creating a new file without leaving broot
    # # {
    # #     name: touch
    # #     invocation: touch {new_file}
    # #     execution: "touch {directory}/{new_file}"
    # #     leave_broot: false
    # # }
    #
    # # A standard recommended command for editing files, that you
    # # can customize.
    # # If $EDITOR isn't set on your computer, you should either set it using
    # #  something similar to
    # #   export EDITOR=/usr/local/bin/nvim
    # #  or just replace it with your editor of choice in the 'execution'
    # #  pattern.
    # #  If your editor is able to open a file on a specific line, use {line}
    # #   so that you may jump directly at the right line from a preview.
    # # Example:
    # #  execution: nvim +{line} {file}
    # {
    #     invocation: edit
    #     shortcut: e
    #     execution: "$EDITOR +{line} {file}"
    #     leave_broot: false
    # }
    #
    # # A convenient shortcut to create new text files in
    # # the current directory or below
    # {
    #     invocation: create {subpath}
    #     execution: "$EDITOR {directory}/{subpath}"
    #     leave_broot: false
    # }
    #
    # {
    #     invocation: git_diff
    #     shortcut: gd
    #     leave_broot: false
    #     execution: "git difftool -y {file}"
    # }
    #
    # # On ctrl-b, propose the creation of a copy of the selection.
    # # While this might occasionally be useful, this verb is mostly here
    # # as an example to demonstrate rare standard groups like {file-stem}
    # # and {file-dot-extension} and the auto_exec verb property which
    # # allows verbs not executed until you hit enter
    # {
    #     invocation: "backup {version}"
    #     key: ctrl-b
    #     leave_broot: false
    #     auto_exec: false
    #     execution: "cp -r {file} {parent}/{file-stem}-{version}{file-dot-extension}"
    # }
    #
    # # This verb lets you launch a terminal on ctrl-T
    # # (on exit you'll be back in broot)
    # {
    #     invocation: terminal
    #     key: ctrl-t
    #     execution: "$SHELL"
    #     set_working_dir: true
    #     leave_broot: false
    # }
    #
    # # Here's an example of a shortcut bringing you to your home directory
    # # {
    # #     invocation: home
    # #     key: ctrl-home
    # #     execution: ":focus ~"
    # # }
    #
    # # A popular set of shortcuts for going up and down:
    # #
    # # {
    # #     key: ctrl-k
    # #     execution: ":line_up"
    # # }
    # # {
    # #     key: ctrl-j
    # #     execution: ":line_down"
    # # }
    # # {
    # #     key: ctrl-u
    # #     execution: ":page_up"
    # # }
    # # {
    # #     key: ctrl-d
    # #     execution: ":page_down"
    # # }
    #
    # # If you develop using git, you might like to often switch
    # # to the git status filter:
    # # {
    # #     key: ctrl-g
    # #     execution: ":toggle_git_status"
    # # }
    #
    # # You can reproduce the bindings of Norton Commander
    # # on copying or moving to the other panel:
    # # {
    # #     key: F5
    # #     external: "cp -r {file} {other-panel-directory}"
    # #     leave_broot: false
    # # }
    # # {
    # #     key: F6
    # #     external: "mv {file} {other-panel-directory}"
    # #     leave_broot: false
    # # }
  ];

  programs.broot.settings.skin = {
    default = "gray(22) none  / gray(20) none";
    tree = "gray(8) None  / gray(4) None";
    parent = "gray(18) None  / gray(13) None";
    file = "gray(22) None  / gray(15) None";
    directory = "ansi(110) None bold / ansi(110) None";
    exe = "Cyan None";
    link = "Magenta None";
    pruning = "gray(12) None Italic";

    perm__ = "gray(5) None";
    perm_r = "ansi(94) None";
    perm_w = "ansi(132) None";
    perm_x = "ansi(65) None";

    owner = "ansi(138) None";
    group = "ansi(131) None";
    count = "ansi(138) gray(4)";
    dates = "ansi(66) None";
    sparse = "ansi(214) None";

    content_extract = "ansi(29) None";
    content_match = "ansi(34) None";

    device_id_major = "ansi(138) None";
    device_id_sep = "ansi(102) None";
    device_id_minor = "ansi(138) None";

    git_branch = "ansi(178) None";
    git_insertions = "ansi(28) None";
    git_deletions = "ansi(160) None";
    git_status_current = "gray(5) None";
    git_status_modified = "ansi(28) None";
    git_status_new = "ansi(94) None bold";
    git_status_ignored = "gray(17) None";
    git_status_conflicted = "ansi(88) None";
    git_status_other = "ansi(88) None";

    selected_line = "None gray(6)  / None gray(4)";
    char_match = "Green None";
    file_error = "Red None";

    flag_label = "gray(15) gray(2)";
    flag_value = "ansi(178) gray(2) bold";

    input = "White gray(2)  / gray(15) None";

    status_error = "gray(22) ansi(124)";
    status_job = "ansi(220) gray(5)";
    status_normal = "gray(20) gray(4)  / gray(2) gray(2)";
    status_italic = "ansi(178) gray(4)  / gray(2) gray(2)";
    status_bold = "ansi(178) gray(4) bold / gray(2) gray(2)";
    status_code = "ansi(229) gray(4)  / gray(2) gray(2)";
    status_ellipsis = "gray(19) gray(1)  / gray(2) gray(2)";

    purpose_normal = "gray(20) gray(2)";
    purpose_italic = "ansi(178) gray(2)";
    purpose_bold = "ansi(178) gray(2) bold";
    purpose_ellipsis = "gray(20) gray(2)";

    scrollbar_track = "gray(7) None  / gray(4) None";
    scrollbar_thumb = "gray(22) None  / gray(14) None";

    help_paragraph = "gray(20) None";
    help_bold = "ansi(178) None bold";
    help_italic = "ansi(229) None";
    help_code = "gray(21) gray(3)";
    help_headers = "ansi(178) None";
    help_table_border = "ansi(239) None";

    preview = "gray(20) gray(1)  / gray(18) Black";
    preview_title = "gray(23) None  / gray(21) None";
    preview_line_number = "gray(12) None";
    preview_match = "None ansi(29)";

    hex_null = "gray(8) None";
    hex_ascii_graphic = "gray(18) None";
    hex_ascii_whitespace = "ansi(143) None";
    hex_ascii_other = "ansi(215) None";
    hex_non_ascii = "ansi(167) None";

    staging_area_title = "gray(22) gray(2)  / gray(20) gray(3)";
    mode_command_mark = "gray(5) ansi(204) bold";
  };
}
