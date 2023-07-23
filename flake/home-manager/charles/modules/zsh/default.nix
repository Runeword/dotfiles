{
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableVteIntegration = false;
  programs.zsh.autocd = false;
  programs.zsh.initExtra = builtins.readFile ./.zshrc;
  programs.zsh.zplug = {
    enable = true;
    plugins = [
      {name = "olets/zsh-abbr";}
    ];
  };
}
