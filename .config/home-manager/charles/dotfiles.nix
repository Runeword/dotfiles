{
  lib,
  pkgs,
  ...
}:
let
  git = "${pkgs.git}/bin/git";
  httpsUrl = "https://github.com/Runeword/dotfiles.git";
  sshUrl = "git@github.com:Runeword/dotfiles.git";
in
{
  # Reproduce the bare dotfiles repo's git-dir plumbing on every `home-manager
  # switch`. None of this lives in the work tree ($HOME), so the repo can't
  # track it itself — declaring it here is what makes a new machine a one-shot
  # `home-manager switch` instead of a manual bootstrap.
  home.activation.dotfilesBareRepo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    dotgit="$HOME/.dotfiles"

    # Fresh machine (no repo yet): clone over HTTPS — public repo, no auth — then
    # check the tree out into $HOME. Runs only on the first switch. --force lets
    # the tracked files win over placeholder files already sitting in $HOME.
    if [ ! -e "$dotgit/HEAD" ]; then
      ${git} clone --bare "${httpsUrl}" "$dotgit" || true
      if [ -e "$dotgit/HEAD" ]; then
        ${git} --git-dir="$dotgit" config core.bare false
        ${git} --git-dir="$dotgit" config core.worktree "$HOME"
        ${git} --git-dir="$dotgit" --work-tree="$HOME" checkout --force main || true
      fi
    fi

    # Every switch (idempotent): the ignore-all rule plus the local config the
    # detached-work-tree layout needs. Origin is set to the SSH URL so pushes
    # use your key, even though the initial clone was over HTTPS.
    if [ -e "$dotgit/HEAD" ]; then
      printf '*\n' > "$dotgit/info/exclude"
      ${git} --git-dir="$dotgit" config core.bare false
      ${git} --git-dir="$dotgit" config core.worktree "$HOME"
      ${git} --git-dir="$dotgit" config status.showUntrackedFiles no
      ${git} --git-dir="$dotgit" config remote.origin.url "${sshUrl}"
      ${git} --git-dir="$dotgit" config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
      ${git} --git-dir="$dotgit" config branch.main.remote origin
      ${git} --git-dir="$dotgit" config branch.main.merge refs/heads/main
    fi
  '';
}
