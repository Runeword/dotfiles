{ pkgs }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [
    pkgs.zsh
    pkgs.zsh-autosuggestions
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    ${pkgs.lib.mkFile "./../.." "config/zsh/zshrc" ".config/zsh/.zshrc"}
    ${pkgs.lib.mkFile "./../.." "config/shell" ".config/shell"}

    mkdir -p $out/bin
    wrapProgram $out/bin/zsh \
      --set ZDOTDIR "$out/.config/zsh" \
      --set OUT "$out"
  '';
}
