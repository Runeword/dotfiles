{ config, pkgs, lib, inputs, ... }: {
  imports = [
  ./programs
  ./home
  ./services
  ];

  fonts.fontconfig.enable = true;

  # home.packages = [ inputs.src-cli.packages.x86_64-linux.default ];
  # xresources.properties."Xft.dpi" = 200; 

  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';
}
