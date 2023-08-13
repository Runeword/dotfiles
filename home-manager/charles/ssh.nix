{
  programs.ssh.enable = true;

  programs.ssh.extraConfig = ''
  AddKeysToAgent yes
  IdentitiesOnly yes
  '';

  programs.ssh.matchBlocks.github = {
    host = "github.com";
    hostname = "github.com";
    identityFile = "~/.ssh/id_ed25519_home";
    extraOptions.UpdateHostKeys = "no";
    extraOptions.PreferredAuthentications = "publickey";
  };

  programs.ssh.matchBlocks.gitlab = {
    host = "gitlab.com";
    hostname = "gitlab.com";
    identityFile = "~/.ssh/id_ed25519_home";
    extraOptions.UpdateHostKeys = "no";
    extraOptions.PreferredAuthentications = "publickey";
  };

  programs.ssh.matchBlocks."gitlab.0" = {
    host = "gitlab.0.com";
    hostname = "gitlab.com";
    identityFile = "~/.ssh/id_ed25519_0";
    extraOptions.UpdateHostKeys = "no";
    extraOptions.PreferredAuthentications = "publickey";
  };
}
