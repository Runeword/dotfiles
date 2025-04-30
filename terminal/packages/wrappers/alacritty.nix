{
  pkgs,
  extraPackages,
  extraFonts,
}:
pkgs.runCommand "alacritty"
  {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  }
  ''
    ${pkgs.lib.mkLink "config/alacritty" ".config/alacritty"}
    ${pkgs.lib.mkLink "extraConfig/bat" ".config/bat"}

    # use makeWrapper instead of wrapProgram to preserve the original process name 'alacritty'
    # wrapProgram would have named it alacritty-wrapped instead
    mkdir -p $out/bin
    makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
    --prefix PATH : ${pkgs.lib.makeBinPath extraPackages} \
    --set FONTCONFIG_FILE ${pkgs.makeFontsConf { fontDirectories = extraFonts; }} \
    --add-flags "--config-file $out/.config/alacritty/alacritty.toml" \
  ''
