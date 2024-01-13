{
  home.shellAliases = {
    # up = "up(){ realesrgan-ncnn-vulkan -i \"$1\" -o output.png; }; up";
    shn = "shutdown now";
    chrome = "google-chrome-stable";
    # color = "colorpicker"; # X11
    win = "xprop WM_CLASS";
    cd = "__zoxide_z";
    h = "__zoxide_zi";
    # sin = "$HOME/.screenlayout/single.sh && feh --bg-fill $HOME/.config/Skin\ The\ Remixes.png";
    # dua = "$HOME/.screenlayout/dual.sh";
    pr = "watch progress -q";
    mv = "mv --verbose";
    md = "mkdir --parents";
    cp = "cp --recursive --verbose";
    bb = "br -c ':toggle_hidden;:toggle_perm;:toggle_dates'";
    bt = "__bluetoothctl";
    wi = "__nmcli";
    b = "bluetuith";
    f = "fc-list : family style | fzf";
    # l = "command ls --almost-all --color --width 90";
    # ll = "command ls -lt --almost-all --color --human-readable --classify";
    # ll = "exa --long --all --octal-permissions --group-directories-first --total-size --sort=time";
    ll = ''
    exa --long --all --color=always --octal-permissions --group-directories-first --total-size --sort=time | fzf \
    --ansi \
    --multi \
    --delimiter : \
    --reverse \
    --border none \
    --cycle \
    --info=inline:"" \
    --height 70% \
    --no-separator \
    '';
    l = "exa --all --group-directories-first --sort=time";
    n = "nvim";
    r = "gomi -rf";
    ru = "gomi --restore";
    rd = "rm -rf $HOME/.gomi";
    o = "__open_file";
    s = "__ripgrep";
    i = "kitten icat";
    a = ''eval "$(alias | fzf --delimiter='=' --bind "enter:execute(echo {2} | tr -d \"'\")+abort")"'';
    ".." = "cd ..";
    "..." = "cd ../..";
    ss = "src search";
    c = "wl-copy";
    p = "wl-paste";
    # xc = "xclip -selection c";
    # xp = "xclip -selection c -o";
    # b = "br"; # :open_preview
    # w = "waypaper";
    # w = "__wallpaper";

    # hm = "hyprctl monitors";
    # hhp = "hyprctl hyprpaper preload";
    # hhw = "hyprctl hyprpaper wallpaper";
    play = "asciinema play";
    "rec" = "asciinema rec $HOME/Downloads/$(date +'%Y-%m-%d_%H-%M-%S').cast";
    key = "showkey -a";
    color = "hyprpicker --autocopy --format=hex";
    cheat = "navi --cheatsh";
    tldr = "navi --tldr";
    od = "ouch decompress";
    oc = "ouch compress";
    ol = "ouch list";
    gparted = "sudo -E gparted";
    ventoy = "sudo ventoy-web";
    bios = "sudo dmidecode -s bios-version";
    t = "__switch_session";

    # ______________________________________ NIX
    hs = "home-manager switch --flake $HOME/home-manager";
    hu = "__update_flake_inputs $HOME/home-manager";
    hp = "home-manager packages | fzf --inline-info";
    hv = "home-manager --version";
    store = "cd /nix/store && __open_file";
    ns = "sudo nixos-rebuild switch --flake $HOME/nixos#$USER";
    ni = "nix-info -m";
    nb = "sudo nixos-rebuild boot --flake $HOME/nixos#$USER";
    nd = "read -p 'nix develop $HOME#' devShellName && nix develop $HOME#$devShellName";
    nu = "__update_flake_inputs $HOME/nixos";
    nt = "__use_flake_template $HOME/templates";
    nv = "nixos-version";
    fl = "nix flake lock";
    fs = "nix flake show";
    fm = "nix flake metadata";
    # nt = "printf 'Enter the template name: ' >&2 && read templateName && nix flake new --template $HOME/templates#$templateName";
    nr = "nix run";
    hm = "nvim $HOME/home-manager/$USER/packages.nix";
    ng = "sudo nix-collect-garbage -d";
    ngd = "nix-env --delete-generations +10";
    ngl = "nix-env --list-generations";

    # ______________________________________ QMK
    qc = "(cd $HOME/.config/qmk && qmk compile -kb ferris/sweep -km Runeword)";
    qfl = "(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-left)";
    qfr = "(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-right)";
    qcd = "cd $HOME/.config/qmk/qmk_firmware/keyboards/ferris/keymaps/Runeword";
    qd = "(cd $HOME/.config/qmk && qmk generate-compilation-database -kb ferris/sweep -km Runeword)";

    # ______________________________________ NETWORK
    wo = "nmcli radio wifi on";
    wf = "nmcli radio wifi off";
    # nmcli networking off
    # nmcli networking on

    # ______________________________________ CHEZMOI
    chd = "chezmoi diff --reverse";
    chi = "chezmoi ignored";
    chc = "chezmoi cd";

    # ______________________________________ GO
    gog = "go get";
    gomt = "go mod tidy";
    goc = "go clean -modcache";

    # ______________________________________ NPM
    npl = "npm ls --depth=0";
    npg = "npm ls -g --depth=0";
    npd = "npm run dev";
    npi = "npm i";

    # ______________________________________ GIT
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
