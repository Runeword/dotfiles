{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nushell.enable = true;
  # programs.nushell.shellAliases = config.home.shellAliases;
}
