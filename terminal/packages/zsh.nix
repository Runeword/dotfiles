{ pkgs, mkOutOfStoreSymlink }:

pkgs.symlinkJoin {
  name = "zsh-with-config";
  paths = [ pkgs.zsh ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    # Create wrapper scripts for zsh-autosuggestions
    mkdir -p $out/bin

    # Autosuggestions script
    cat > $out/bin/zsh-autosuggestions << EOF
    #!/bin/sh
    exec ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh "\$@"
    EOF
    chmod +x $out/bin/zsh-autosuggestions

    ln -sf ${mkOutOfStoreSymlink "config/zsh/zshrc"} $out/.zshrc

    wrapProgram $out/bin/zsh \
      --set ZDOTDIR $out \
  '';
}
