{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [ pkgs.zsh ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/etc

    ln -sf ${mkOutOfStoreSymlink "config/zsh/zshrc"} $out/etc/zshrc

    wrapProgram $out/bin/zsh \
      --set ZDOTDIR $out/etc \
      --add-flags "-i"
  '';
}
