# Custom Alacritty with additional packages and configuration
{
  pkgs,
  mkOutOfStoreSymlink,
  extraPackages,
}:

let
  extraFonts = [
    pkgs.nerd-fonts.sauce-code-pro
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.caskaydia-mono
  ];
in
pkgs.runCommand "alacritty"
  {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  }
  ''
    mkdir -p $out/bin
    mkdir -p $out/.config/alacritty

    ln -sf ${mkOutOfStoreSymlink "config/alacritty/alacritty.toml"} $out/.config/alacritty/alacritty.toml

    makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
      --prefix PATH : ${pkgs.lib.makeBinPath extraPackages} \
      --set FONTCONFIG_FILE ${pkgs.makeFontsConf { fontDirectories = extraFonts; }} \
      --set XDG_CONFIG_HOME "$out/.config"
  ''
