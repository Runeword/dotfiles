{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "tmux-with-config";
  paths = [
    pkgs.tmux
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/.config/tmux/plugins

    ln -sf ${mkOutOfStoreSymlink "config/tmux"} $out/.config/tmux

    ln -sf ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/.config/tmux/plugins/resurrect

    wrapProgram $out/bin/tmux \
      --set XDG_CONFIG_HOME "$out/.config" \
      --set TMUX_SHELL ${pkgs.zsh}/bin/zsh
  '';
}
