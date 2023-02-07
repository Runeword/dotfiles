{ config, pkgs, lib, ... }: {
  imports = [ ./programs ./home ./services ];

  fonts.fontconfig.enable = true;
}
