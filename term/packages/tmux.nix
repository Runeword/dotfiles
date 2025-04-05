{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "tmux-with-config";
  paths = [ pkgs.tmux ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/.config

    ln -sf ${mkOutOfStoreSymlink "config/tmux"} $out/.config/tmux

    mkdir -p $out/share/tmux-plugins

    ln -sf ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/share/tmux-plugins/resurrect
    ln -sf ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf $out/share/tmux-plugins/tmux-fzf

    wrapProgram $out/bin/tmux \
    --set XDG_CONFIG_HOME "$out/.config"
  '';
}
