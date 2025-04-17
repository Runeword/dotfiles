{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "bash-with-config";
  paths = [ pkgs.bash ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/bin

    ln -sf ${mkOutOfStoreSymlink "config/bash/bashrc"} $out/.bashrc

    wrapProgram $out/bin/bash \
      --add-flags "--rcfile $out/.bashrc"
  '';
}
