{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableVteIntegration = true;
  programs.zsh.autocd = false;
  programs.zsh.initExtra = builtins.readFile ./.zshrc;
}
