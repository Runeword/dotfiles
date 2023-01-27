{ config, pkgs, lib, ... }: {
  imports = [ ./programs ./home ];

  fonts.fontconfig.enable = true;
}
