{
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableCompletion = false;

  programs.zsh.initExtra = builtins.readFile ./.zshrc;
  programs.zsh.initExtraFirst = builtins.readFile ./.zshrc_first;

  programs.zsh.zplug = {
    enable = true;
    plugins = [
      {name = "marlonrichert/zsh-autocomplete";}
      # {name = zdharma-continuum/fast-syntax-highlighting";}
      {
        name = "olets/zsh-abbr";
        # tags = ["at:82fc2b53d7b1c2df60fdea6f13701cff9c536197"];
      }
    ];
  };
}
