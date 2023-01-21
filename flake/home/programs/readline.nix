{ config, pkgs, lib, ... }: {

  programs.readline.enable = true;
  programs.readline.includeSystemConfig = false;
  programs.readline.variables.bind-tty-special-chars = false; # override default readline bindings

  programs.readline.bindings = {
    "\\C-u" = "kill-whole-line"; # ctrl + u
    "\\C-\\b" = "backward-kill-word"; # ctrl + backspace
    "\\e[A" = "history-search-backward"; # arrow up
    "\\e[B" = "history-search-forward"; # arrow down
    "\\e[6~" = ""; # page down
    "\\e[5~" = ""; # page up
    # "\e[1;5B"= "history-search-forward"; # ctrl + arrow down
    # "\e[1;5A"= "history-search-backward"; # ctrl + arrow up
  };
}
