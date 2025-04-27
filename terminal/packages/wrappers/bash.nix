{ pkgs }:

pkgs.symlinkJoin {
  name = "bash-with-config";
  paths = [ pkgs.bash ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    ${pkgs.lib.mkFile "./../../" "config/bash/bashrc" ".config/bash/.bashrc"}
    ${pkgs.lib.mkFile "./../../" "config/shell" ".config/shell"}

    mkdir -p $out/bin
    wrapProgram $out/bin/bash \
      --add-flags "--rcfile $out/.config/bash/.bashrc" \
      --set OUT "$out"
  '';
}
