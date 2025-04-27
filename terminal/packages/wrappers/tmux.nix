{ pkgs }:

let
  zsh = import ./zsh.nix { inherit pkgs; };
in

pkgs.symlinkJoin {
  name = "tmux-with-config";
  paths = [ pkgs.tmux ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    ${pkgs.lib.mkLink (pkgs.lib.mkOutOfStoreSymlink "config/tmux/tmux.conf") "/.config/tmux/tmux.conf"}
    ${pkgs.lib.mkLink (pkgs.lib.mkOutOfStoreSymlink "config/shell/functions/tmux.sh") "/.config/shell/functions/tmux.sh"}
    ${pkgs.lib.mkLink "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect" "/.config/tmux/plugins/resurrect"}

    # cp ${pkgs.lib.cleanSource ./../../config/tmux/tmux.conf} $out/.config/tmux/tmux.conf
    # cp ${pkgs.lib.cleanSource ./../../config/shell/functions/tmux.sh} $out/.config/shell/functions/tmux.sh
    # cp -r ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect $out/.config/tmux/plugins/resurrect

    mkdir -p $out/bin
    wrapProgram $out/bin/tmux \
    --set TMUX_SHELL ${zsh}/bin/zsh \
    --set TMUX_OUT "$out" \
    --add-flags "-f $out/.config/tmux/tmux.conf"
  '';
}
