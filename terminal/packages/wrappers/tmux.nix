{ pkgs }:

let
  zsh = import ./zsh.nix { inherit pkgs; };
in

pkgs.symlinkJoin {
  name = "tmux-with-config";
  paths = [ pkgs.tmux ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/.config/tmux/plugins
    mkdir -p $out/.config/shell/functions

    ln -sf ${pkgs.lib.mkOutOfStoreSymlink "config/tmux/tmux.conf"} $out/.config/tmux/tmux.conf
    ln -sf ${pkgs.lib.mkOutOfStoreSymlink "config/shell/functions/tmux.sh"} $out/.config/shell/functions/tmux.sh
    ln -sf ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/.config/tmux/plugins/resurrect

    # cp ${pkgs.lib.cleanSource ./../../config/tmux/tmux.conf} $out/.config/tmux/tmux.conf
    # cp ${pkgs.lib.cleanSource ./../../config/shell/functions/tmux.sh} $out/.config/shell/functions/tmux.sh
    # cp -r ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/.config/tmux/plugins/resurrect


    wrapProgram $out/bin/tmux \
      --set TMUX_SHELL ${zsh}/bin/zsh \
      --set TMUX_OUT "$out" \
      --add-flags "-f $out/.config/tmux/tmux.conf"
  '';
}
