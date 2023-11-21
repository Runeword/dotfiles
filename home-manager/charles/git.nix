{
  home.shellAliases = {
    gn = "nvim $(git status -s | awk '{print $2}')";
    gs = "git status";
    gpl = "git pull";
    gp = "git push";
    gpo = "git push origin";
    # gt = "git stash";
    gt = "git-forgit stash_push"; # git stash push
    gtl = "git-forgit stash_show"; # git stash list
    gty = "git stash apply";
    gd = "git-forgit diff"; # git diff
    gdc = "git diff --cached";
    ga = "git-forgit add"; # git add
    gl = "git-forgit log"; # git log
    gb = "git branch";
    gbd = "git-forgit branch_delete"; # git branch -d
    gbl = "git-forgit blame"; # git blame
    gk = "git checkout";
    gk- = "git checkout --";
    gkb = "git-forgit checkout_branch"; # git checkout
    gkf = "git-forgit checkout_file"; # git checkout
    gct = "git-forgit checkout_tag"; # git checkout
    gco = "git-forgit checkout_commit"; # git checkout
    gc = "git commit";
    gcl = "git clone";
    gcp = "git-forgit cherry_pick"; # git cherry-pick
    gm = "git merge";
    grb = "git-forgit rebase"; # git rebase
    gr = "git reset";
    grh = "git-forgit reset_head"; # git reset
    # grh = "git reset HEAD~1";
    gwa = "git worktree add";
    gwl = "git worktree list";
    gwr = "git worktree remove";
  };
}
