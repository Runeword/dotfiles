{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "tmux-with-config";
  paths = [
    pkgs.tmux
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/.config/tmux/plugins
    mkdir -p $out/.config/shell/functions

    ln -sf ${mkOutOfStoreSymlink "config/tmux/tmux.conf"} $out/.config/tmux/tmux.conf

    ln -sf ${mkOutOfStoreSymlink "config/shell/functions/tmux.sh"} $out/.config/shell/functions/tmux.sh

    ln -sf ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/.config/tmux/plugins/resurrect

    wrapProgram $out/bin/tmux \
      --set XDG_CONFIG_HOME "$out/.config" \
      --set TMUX_SHELL ${pkgs.zsh}/bin/zsh \
      # --add-flags "-f $out/.config/tmux/tmux.conf"
  '';
}
