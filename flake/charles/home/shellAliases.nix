{
  home.shellAliases = {
    shn="shutdown now";
    chrome="google-chrome-stable";
    pick="colorpicker";
    slg="$HOME/.screenlayout/single.sh && feh --bg-fill ~/.config/Skin\ The\ Remixes.png";
    dual="$HOME/.screenlayout/dual.sh";
    hsf="home-manager switch --flake ~/flake";
    nrs="sudo nixos-rebuild switch";

    # ______________________________________QMK
    qc="qmk compile -kb ferris/sweep -km runeword";
    qfl="qmk flash -kb ferris/sweep -km runeword -bl dfu-split-left";
    qfr="qmk flash -kb ferris/sweep -km runeword -bl dfu-split-right";
    qj="qmk json2c -o _keymap.c";

    # ______________________________________ARCH
    pa="sudo pacman -Syyu";
    par="pacman -R";
    pas="pacman -S";
    pass="pacman -Ss";
    ya="yay -Syyu";

    # ______________________________________NPM
    nl="npm ls --depth=0";
    nlg="npm ls -g --depth=0";
    nup="npm run use:prod";
    nud="npm run use:dev";
    nd="npm run dev";
    ni="npm i";

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
    trw="tmux rename-window";
    tns="tmux new -s";
    tks="tmux kill-session";
    trs="tmux rename-session";
    tkk="tmux kill-server";
    tss="$HOME/.config/tmux/plugins/tmux-resurrect/scripts/save.sh";
    trr="[[ '$TERM_PROGRAM' == 'tmux' ]] && $HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh";

    # ______________________________________GIT
    gs="git status";
    gst="git stash";
    gstl="git stash list";
    gsta="git stash apply";
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
