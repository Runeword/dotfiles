{pkgs, ...}: {
  programs.bat.enable = true;
  programs.bat.config.theme = "Dracula";
  # programs.bat.themes = {
  #   dracula = builtins.readFile (pkgs.fetchFromGitHub {
  #       owner = "dracula";
  #       repo = "sublime";
  #       rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
  #       sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
  #     }
  #     + "/Dracula.tmTheme");
  #   # dracula = builtins.readFile ./default.tmTheme;
  # };
}
