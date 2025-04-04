# Custom Tmux with configuration
{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "tmux-with-config";
  paths = [ pkgs.tmux ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/.config

    ln -sf ${mkOutOfStoreSymlink "config/tmux"} $out/.config/tmux

    # ln -sf ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/.config/tmux/plugins/resurrect
    # ln -sf ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf $out/.config/tmux/plugins/tmux-fzf

    wrapProgram $out/bin/tmux \
      --set XDG_CONFIG_HOME "$out/.config"
  '';
}
