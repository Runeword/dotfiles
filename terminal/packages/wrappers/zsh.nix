{ pkgs }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [
    pkgs.zsh
    pkgs.zsh-autosuggestions
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    ${pkgs.lib.mkLink "${pkgs.lib.flakePath}/config/zsh/zshrc" ".config/zsh/.zshrc"}
    ${pkgs.lib.mkLink "${pkgs.lib.flakePath}/config/shell" ".config/shell"}

    mkdir -p $out/bin
    wrapProgram $out/bin/zsh \
      --set ZDOTDIR "$out/.config/zsh" \
      --set OUT "$out"
  '';
}
