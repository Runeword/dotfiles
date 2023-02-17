{ config, pkgs, libs, ... }: {
  imports = [
    ./readline.nix
    ./alacritty.nix
    ./i3.nix
    ./feh.nix
    ./ssh.nix
    ./tmux.nix
    ./neovim.nix
  ];

  programs.home-manager.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.fileWidgetCommand = "fd --hidden --follow --no-ignore --max-depth 1 --exclude .git --exclude node_modules";
  programs.fzf.defaultOptions = [ "--no-separator" ];

  programs.rofi.enable = true;

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.bashrcExtra = ''
    # bind ctrl-n to neovim
    bind -x '"\C-n":"nvim"'

    # unbind alt-number
    for i in "-" {0..9}; do bind -r "\e$i"; done

    # unbind ctrl-s and ctrl-q (terminal scroll lock)
    stty -ixon

    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent -t 2h > "$XDG_RUNTIME_DIR/ssh-agent.env"
    fi
    if [[ ! "$SSH_AUTH_SOCK" ]]; then
        source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    fi
  '';
}
