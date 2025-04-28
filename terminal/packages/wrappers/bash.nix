{ pkgs }:

pkgs.symlinkJoin {
  name = "bash-with-config";
  paths = [ pkgs.bash ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    ${pkgs.lib.mkLink "config/bash/bashrc" ".config/bash/.bashrc"}
    ${pkgs.lib.mkLink "config/shell" ".config/shell"}

    wrapProgram $out/bin/bash \
      --add-flags "--rcfile $out/.config/bash/.bashrc" \
      --set OUT "$out"
  '';
}
