{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fish.enable = true;

  programs.fish.shellAbbrs = config.home.shellAliases;
  programs.fish.interactiveShellInit = "echo 'interactiveShellInit'";
  programs.fish.loginShellInit = "echo 'loginShellInit'";
  programs.fish.shellInit = builtins.readFile ./config.fish;

  # programs.fish.plugins = [
  #   {
  #     name = "bass";
  #     src = pkgs.fishPlugins.bass.src;
  #   }
  # ];
}
