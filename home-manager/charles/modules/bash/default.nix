{
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.bashrcExtra = builtins.readFile ./bashrc;
}
