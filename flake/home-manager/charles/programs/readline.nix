{
  programs.readline.enable = true;
  programs.readline.includeSystemConfig = false;
  programs.readline.variables.bind-tty-special-chars = false; # override default readline bindings
  programs.readline.variables.show-all-if-ambiguous = true; # show all tab-completion options on first tab
  programs.readline.variables.completion-ignore-case = true;
  programs.readline.variables.colored-stats = true;

  programs.readline.bindings = {
    "\\C-i" = "menu-complete"; # tab
    "\\e[Z" = "menu-complete-backward"; # shift + tab
    "\\C-u" = "kill-whole-line";
    "\\C-j" = "unix-line-discard";
    "\\C-\\b" = "backward-kill-word"; # ctrl + backspace
    "\\e[A" = "history-search-backward"; # arrow up
    "\\e[B" = "history-search-forward"; # arrow down
    "\\e[6~" = ""; # page down
    "\\e[5~" = ""; # page up
    # "\e[1;5B"= "history-search-forward"; # ctrl + arrow down
    # "\e[1;5A"= "history-search-backward"; # ctrl + arrow up
  };
}
