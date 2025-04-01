{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [ pkgs.zsh ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    mkdir -p $out/etc
    mkdir -p $out/.config/zsh/plugins

    ln -sf ${mkOutOfStoreSymlink "config/zsh/zshrc"} $out/etc/zshrc

    ln -s ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions $out/.config/zsh/plugins/zsh-autosuggestions

    wrapProgram $out/bin/zsh \
      --set ZDOTDIR $out/etc \
      --set XDG_CONFIG_HOME "$out/.config" \
      --add-flags "-i"
  '';
}
