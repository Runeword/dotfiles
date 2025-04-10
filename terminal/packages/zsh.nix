{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [ pkgs.zsh ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/bin
    mkdir -p $out/share/zsh-autosuggestions
    
    ln -sf ${mkOutOfStoreSymlink "config/zsh/zshrc"} $out/.zshrc
    ln -sf ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh $out/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    wrapProgram $out/bin/zsh \
    --set ZDOTDIR "$out" \
  '';
}
