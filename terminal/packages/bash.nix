{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "bash-with-config";
  paths = [ pkgs.bash ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/bin $out/.config

    ln -sf ${mkOutOfStoreSymlink "config/bash/bashrc"} $out/.bashrc

    wrapProgram $out/bin/bash \
      --set XDG_CONFIG_HOME "$out/.config"
  '';
} 
