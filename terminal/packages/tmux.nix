{ pkgs, mkOutOfStoreSymlink }:

let
  customZsh = import ./zsh.nix { inherit pkgs mkOutOfStoreSymlink; };
in
pkgs.symlinkJoin {
  name = "tmux-with-config";
  paths = [ pkgs.tmux ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/.config
    ln -sf ${mkOutOfStoreSymlink "config/tmux"} $out/.config/tmux

    # Create wrapper scripts for tmux-resurrect
    mkdir -p $out/bin

    # Save script
    cat > $out/bin/tmux-resurrect-save << EOF
    #!/bin/sh
    exec ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh "\$@"
    EOF
    chmod +x $out/bin/tmux-resurrect-save

    # Restore script
    cat > $out/bin/tmux-resurrect-restore << EOF
    #!/bin/sh
    exec ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh "\$@"
    EOF
    chmod +x $out/bin/tmux-resurrect-restore

    wrapProgram $out/bin/tmux \
    --set XDG_CONFIG_HOME "$out/.config" \
    --set TMUX_SHELL ${customZsh}/bin/zsh
  '';
}
