{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "bash-with-config";
  paths = [ pkgs.bash ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/bin
    mkdir -p $out/.config/bash

    ln -sf ${mkOutOfStoreSymlink "config/bash/bashrc"} $out/.config/bash/.bashrc
    ln -sf ${mkOutOfStoreSymlink "config/shell"} $out/.config/shell

    wrapProgram $out/bin/bash \
      --add-flags "--rcfile $out/.config/bash/.bashrc" \
      --set OUT "$out"
  '';
}
