{
  programs.git.enable = true;
  programs.git.userEmail = "60324746+Runeword@users.noreply.github.com";
  programs.git.userName = "Runeword";
  # programs.git.delta.enable = true;

  home.shellAliases = {
    ga = "git add";
    gs = "git status";
    gn = "nvim $(git status -s | awk '{print $2}')";
    gt = "git stash";
    gtl = "git stash list";
    gty = "git stash apply";
    gpl = "git pull";
    gp = "git push";
    gpo = "git push origin";
    gdc = "git diff --cached";
    gc = "git commit";
    gcl = "git clone";
    gcp = "git cherry-pick";
    gk = "git checkout";
    gk-- = "git checkout --";
    gb = "git branch";
    gbd = "git branch -d";
    gl = "git log";
    gm = "git merge";
    grb = "git rebase";
    grs = "git reset";
    grs1 = "git reset HEAD~1";
    gwa = "git worktree add";
    gwl = "git worktree list";
    gwr = "git worktree remove";
  };
}
