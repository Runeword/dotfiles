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

    ln -sf ${mkOutOfStoreSymlink "config/zsh/zshrc"} $out/.zshrc

    wrapProgram $out/bin/zsh \
      --set ZDOTDIR "$out"
  '';
}
