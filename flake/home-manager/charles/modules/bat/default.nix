{pkgs, ...}: {
  bat.enable = true;
  bat.config.theme = "dracula";
  bat.themes = {
    dracula = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "sublime";
        rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
        sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
      }
      + "/Dracula.tmTheme");
  };
}
