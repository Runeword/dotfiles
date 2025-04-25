{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [
    pkgs.zsh
    pkgs.zsh-autosuggestions
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/bin
    mkdir -p $out/.config

    ln -sf ${mkOutOfStoreSymlink "config/zsh/zshrc"} $out/.zshrc
    ln -sf ${mkOutOfStoreSymlink "config/shell"} $out/.config/shell

    wrapProgram $out/bin/zsh \
      --set ZDOTDIR "$out"
  '';
}
