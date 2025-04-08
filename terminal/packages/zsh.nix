{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [ pkgs.zsh ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/etc
    # mkdir -p /home/charles/term/config/zsh/plugins/zsh-autosuggestions

    ln -sf ${mkOutOfStoreSymlink "config/zsh/zshrc"} $out/.zshrc

    # ln -s ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions /home/charles/term/config/zsh/plugins/zsh-autosuggestions

    wrapProgram $out/bin/zsh \
      --set ZDOTDIR $out \
  '';
}
