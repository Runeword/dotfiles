{ config, pkgs, lib, ... }: {
  imports = [ ./programs ./home ./services ];

  fonts.fontconfig.enable = true;

  # xresources.properties."Xft.dpi" = 200; 

  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';
}
