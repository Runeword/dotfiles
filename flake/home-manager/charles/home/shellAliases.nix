{
  home.shellAliases = {
    shn="shutdown now";
    chrome="google-chrome-stable";
    pick="colorpicker";
    slg="$HOME/.screenlayout/single.sh && feh --bg-fill $HOME/.config/Skin\ The\ Remixes.png";
    dual="$HOME/.screenlayout/dual.sh";
    hsf="home-manager switch --flake $HOME/flake";
    nsf="sudo nixos-rebuild switch --flake $HOME/flake#charles";
    nfu="nix flake update $HOME/flake";
    nd="read -p 'nix develop $HOME/flake#' devShell && nix develop $HOME/flake#$devShell";
    wa="watch progress -q";
    c="z";

    # ______________________________________QMK
    qc="(cd $HOME/.config/qmk && qmk compile -kb ferris/sweep -km Runeword)";
    qfl="(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-left)";
    qfr="(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-right)";
    qcd="cd $HOME/.config/qmk/qmk_firmware/keyboards/ferris/keymaps/Runeword";
    qd="(cd $HOME/.config/qmk && qmk generate-compilation-database -kb ferris/sweep -km Runeword)";

    # ______________________________________ARCH
    pa="sudo pacman -Syyu";
    par="pacman -R";
    pas="pacman -S";
    pass="pacman -Ss";
    ya="yay -Syyu";

    # ______________________________________CHEZMOI
    chd="chezmoi diff";
    cha="chezmoi add";
    chy="chezmoi apply";
    chf="chezmoi forget";
    chi="chezmoi ignored";
    chc="chezmoi cd";

    # ______________________________________TMUX
    t="tmux";
    tl="tmux ls";
    ta="tmux attach -t";
    td="tmux detach";
    tnw="tmux new-window -n";
    tkw="tmux kill-window";
    trw="read -p 'Window name: ' name && tmux rename-window $name";
    tns="tmux new -s";
    tks="tmux kill-session";
    trs="read -p 'Session name: ' name && tmux rename-session $name";
    tkk="tmux kill-server";
    tss="/nix/store/n229j84913c7y76h5m4fa1g18gqmgn09-tmuxplugin-resurrect-unstable-2022-05-01/share/tmux-plugins/resurrect/scripts/save.sh";
    trr="[[ '$TERM_PROGRAM' == 'tmux' ]] && /nix/store/n229j84913c7y76h5m4fa1g18gqmgn09-tmuxplugin-resurrect-unstable-2022-05-01/share/tmux-plugins/resurrect/scripts/restore.sh";

    # ______________________________________GIT
    gs="git status";
    gt="git stash";
    gtl="git stash list";
    gty="git stash apply";
    gpl="git pull";
    gp="git push";
    gpo="git push origin";
    gd="git diff";
    gdc="git diff --cached";
    gc="git commit";
    gcl="git clone";
    gcp="git cherry-pick";
    gk="git checkout";
    gk--="git checkout --";
    gb="git branch";
    gbd="git branch -d";
    gl="git log";
    ga="git add";
    gm="git merge";
    grb="git rebase";
    grs="git reset";
    grs1="git reset HEAD~1";
    gwa="git worktree add";
    gwl="git worktree list";
    gwr="git worktree remove";
  };
}
