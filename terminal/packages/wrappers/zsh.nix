{ pkgs }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [
    pkgs.zsh
    pkgs.zsh-autosuggestions
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/bin
    mkdir -p $out/.config/zsh

    ln -sf ${pkgs.lib.mkOutOfStoreSymlink "config/zsh/zshrc"} $out/.config/zsh/.zshrc
    ln -sf ${pkgs.lib.mkOutOfStoreSymlink "config/shell"} $out/.config/shell

    wrapProgram $out/bin/zsh \
      --set ZDOTDIR "$out/.config/zsh" \
      --set OUT "$out"
  '';
}
