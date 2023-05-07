{
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.settings = {
    line_break.disabled = true;
    cmd_duration.min_time = 10000;
    cmd_duration.format = "[$duration]($style) ";
    git_status.disabled = true;
    character.disabled = true;
  };
}
