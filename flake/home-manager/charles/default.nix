{ config, pkgs, lib, ... }: {
  imports = [ ./programs ./home ./services ];

  fonts.fontconfig.enable = true;
  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';
}
