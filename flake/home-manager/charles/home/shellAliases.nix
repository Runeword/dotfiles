{
  home.shellAliases = {
    shn = "shutdown now";
    chrome = "google-chrome-stable";
    pick = "colorpicker";
    win = "xprop WM_CLASS";
    sin = "$HOME/.screenlayout/single.sh && feh --bg-fill $HOME/.config/Skin\ The\ Remixes.png";
    dua = "$HOME/.screenlayout/dual.sh";
    wa = "watch progress -q";
    mv = "mv -v";
    cp = "cp -v";
    mkdir = "mkdir -p";
    xo = "xdg-open";
    oi = "kitty +kitten icat";
    n = "nvim";
    r = "trash";
    l = "ls -A";
    ll = "ls -hAlt";
    cd = "__zoxide_z";
    cdi = "__zoxide_zi";
    c = "cd $(fd --type directory --hidden --follow --no-ignore --exclude .git --exclude node_modules | fzf --preview 'ls -AxF {} | head -$FZF_PREVIEW_LINES' --preview-window right,50%,noborder --no-scrollbar)";
    ca = "cd $(fd --type directory --hidden --follow --no-ignore | fzf)";
    o = "xdg-open $(fd --type file --hidden --follow --no-ignore --exclude .git --exclude node_modules | fzf)";

    # ______________________________________ NIX
    hs = "home-manager switch --flake $HOME/flake";
    hp = "home-manager packages | fzf";
    ns = "sudo nixos-rebuild switch --flake $HOME/flake#charles";
    nd = "read -p 'nix develop $HOME/flake#' devShellName && nix develop $HOME/flake#$devShellName";
    ne = ''
    read -p 'use flake github:Runeword/dotfiles?dir=templates/' templateName \
    && echo "use flake \"github:Runeword/dotfiles?dir=templates/$templateName\"" >> .envrc \
    && direnv allow
    '';
    nfi = "read -p 'nix flake init -t $HOME/templates#' templateName && nix flake init -t $HOME/templates#$templateName";
    nfu = "nix flake update $HOME/flake";
    nfs = "nix flake show";
    nfl = "nix flake lock";
    nr = "nix run";
    ng = "nix-collect-garbage";

    # ______________________________________ QMK
    qc = "(cd $HOME/.config/qmk && qmk compile -kb ferris/sweep -km Runeword)";
    qfl = "(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-left)";
    qfr = "(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-right)";
    qcd = "cd $HOME/.config/qmk/qmk_firmware/keyboards/ferris/keymaps/Runeword";
    qd = "(cd $HOME/.config/qmk && qmk generate-compilation-database -kb ferris/sweep -km Runeword)";

    # ______________________________________ BLUETOOTH
    b = "bluetoothctl";
    bh = "bluetoothctl help";
    bp = "bluetoothctl pair";
    br = "bluetoothctl remove";
    bc = "bluetoothctl connect";
    bd = "bluetoothctl disconnect";
    bt = "bluetoothctl trust";
    bu = "bluetoothctl untrust";
    bs = "bluetoothctl scan on";
    bo = "bluetoothctl power on ";
    bf = "bluetoothctl power off";
    bi = "bluetoothctl info";
    blp = "bluetoothctl devices Paired";
    blc = "bluetoothctl devices Connected";
    blt = "bluetoothctl devices Trusted";
    bl = ''
    choice1=$(bluetoothctl devices | fzf \
    --preview 'bluetoothctl info {2} | head -$FZF_PREVIEW_LINES' \
    --preview-window right,65%,noborder \
    --no-scrollbar \
    --bind='enter:execute(echo {2})+abort'
    ); \
    [ -n "$choice1" ] || exit 0
    choice2=$(echo -e "connect\ndisconnect\npair\nunpair\ntrust\nuntrust" | fzf \
    --preview "bluetoothctl info $choice1 | head -$FZF_PREVIEW_LINES" \
    --preview-window right,65%,noborder \
    --no-scrollbar \
    --bind='enter:execute(echo {1})+abort'
    ); \
    [ -n "$choice2" ] && [ -n "$choice1" ] && bluetoothctl $choice2 $choice1
    '';
    # bl = ''
    # bluetoothctl devices | fzf \
    # --preview 'bluetoothctl info {2} | head -$FZF_PREVIEW_LINES' \
    # --preview-window right,65%,noborder \
    # --no-scrollbar \
    # --header-first \
    # --header='C-p pair  C-c connect  C-t trust' \
    # --bind='ctrl-p:preview:bluetoothctl info {2} | grep "Paired: yes" -q && bluetoothctl remove {2} || bluetoothctl pair {2}' \
    # --bind='ctrl-c:preview:bluetoothctl info {2} | grep "Connected: yes" -q && bluetoothctl disconnect {2} || bluetoothctl connect {2}' \
    # --bind='ctrl-t:preview:bluetoothctl info {2} | grep "Trusted: yes" -q && bluetoothctl untrust {2} || bluetoothctl trust {2}'
    # ''

    # ______________________________________ NETWORK
    wo= "nmcli radio wifi on";
    wf= "nmcli radio wifi off";
    # nmcli networking off
    # nmcli networking on

    # ______________________________________ CHEZMOI
    chd = "chezmoi diff";
    cha = "chezmoi add";
    chy = "chezmoi apply";
    chf = "chezmoi forget";
    chi = "chezmoi ignored";
    chc = "chezmoi cd";

    # ______________________________________ NPM
    npl="npm ls --depth=0";
    npg="npm ls -g --depth=0";
    npd="npm run dev";
    npi="npm i";

    # ______________________________________ TMUX
    t = "tmux";
    tl = "tmux ls";
    ta = "tmux attach -t";
    td = "tmux detach";
    tnw = "tmux new-window -n";
    tkw = "tmux kill-window";
    trw = "read -p 'Window name: ' name && tmux rename-window $name";
    tns = "tmux new -s";
    tks = "tmux kill-session";
    trs = "read -p 'Session name: ' name && tmux rename-session $name";
    tkk = "tmux kill-server";
    tss = "/nix/store/n229j84913c7y76h5m4fa1g18gqmgn09-tmuxplugin-resurrect-unstable-2022-05-01/share/tmux-plugins/resurrect/scripts/save.sh";
    trr = "[[ '$TERM_PROGRAM' == 'tmux' ]] && /nix/store/n229j84913c7y76h5m4fa1g18gqmgn09-tmuxplugin-resurrect-unstable-2022-05-01/share/tmux-plugins/resurrect/scripts/restore.sh";

    # ______________________________________ GIT
    gs = "git status";
    gt = "git stash";
    gtl = "git stash list";
    gty = "git stash apply";
    gpl = "git pull";
    gp = "git push";
    gpo = "git push origin";
    gd = "git diff";
    gdc = "git diff --cached";
    gc = "git commit";
    gcl = "git clone";
    gcp = "git cherry-pick";
    gk = "git checkout";
    gk-- = "git checkout --";
    gb = "git branch";
    gbd = "git branch -d";
    gl = "git log";
    ga = "git add";
    gm = "git merge";
    grb = "git rebase";
    grs = "git reset";
    grs1 = "git reset HEAD~1";
    gwa = "git worktree add";
    gwl = "git worktree list";
    gwr = "git worktree remove";
  };
}
