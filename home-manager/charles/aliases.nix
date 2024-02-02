{
  home.shellAliases = {
    # up = "up(){ realesrgan-ncnn-vulkan -i \"$1\" -o output.png; }; up";
    # xc = "xclip -selection c";
    # xp = "xclip -selection c -o";
    # b = "br"; # :open_preview
    # w = "waypaper";
    # w = "__wallpaper";
    # hhp = "hyprctl hyprpaper preload";
    # hhw = "hyprctl hyprpaper wallpaper";
    # color = "colorpicker"; # X11
    # sin = "$HOME/.screenlayout/single.sh && feh --bg-fill $HOME/.config/Skin\ The\ Remixes.png";
    # dua = "$HOME/.screenlayout/dual.sh";
    # l = "command ls --almost-all --color --width 90";
    # ll = "command ls -lt --almost-all --color --human-readable --classify";
    # ll = "exa --long --all --octal-permissions --group-directories-first --total-size --sort=time";
    # bb = "br -c ':toggle_hidden;:toggle_perm;:toggle_dates'";

    shn = "shutdown now";
    s = "setsid";
    mv = "mv --verbose";
    md = "mkdir --parents";
    cp = "cp --recursive --verbose";
    r = "gomi -rf";
    ru = "gomi --restore";
    rd = "rm -rf $HOME/.gomi";
    cd = "__zoxide_z";
    cdh = "__zoxide_zi";
    ".." = "cd ..";
    "..." = "cd ../..";
    l = "exa --all --group-directories-first --sort=time";
    ll = ''
    exa --long --all --color=always --octal-permissions --group-directories-first --sort=time | \
    fzf --ansi --multi --delimiter : --reverse --border none --cycle --info=inline:"" --height 70% --no-separator
    '';

    # ______________________________________ Hyprland

    ym = "hyprctl monitors";
    yc = "hyprctl clients";

    # ______________________________________ CLIPBOARD

    # c = "!! | wl-copy";
    c = "wl-copy";
    p = "wl-paste";

    # ______________________________________ NETWORK

    b = "bluetuith";
    bl = "__bluetoothctl";
    wi = "__nmcli";
    wo = "nmcli radio wifi on";
    wf = "nmcli radio wifi off";

    # ______________________________________ UTILITY

    play = "asciinema play";
    "rec" = "asciinema rec $HOME/Downloads/$(date +'%Y-%m-%d_%H-%M-%S').cast";
    key = "showkey -a";
    color = "hyprpicker --autocopy --format=hex";
    bios = "sudo dmidecode -s bios-version";
    window = "xprop WM_CLASS";
    progress = "watch progress -q";
    aliases = ''eval "$(alias | fzf --delimiter='=' --bind "enter:execute(echo {2} | tr -d \"'\")+abort")"'';
    font = "fc-list : family style | fzf";
    image = "kitten icat";
    path = "echo \"\${PATH//:/\\n}\"";

    # ______________________________________ ARCHIVE

    od = "ouch decompress";
    oc = "ouch compress";
    ol = "ouch list";

    # ______________________________________ PROGRAM

    gparted = "sudo -E gparted";
    ventoy = "sudo ventoy-web";
    chrome = "google-chrome-stable";
    cheat = "navi --cheatsh";
    tldr = "navi --tldr";
    n = "nvim";

    # ______________________________________ PATH

    np = "nvim $HOME/nixos/configuration.nix";
    hp = "nvim $HOME/home-manager/$USER/packages.nix";
    ov = "nvim $HOME/home-manager/$USER/overlays.nix";
    al = "nvim $HOME/home-manager/$USER/aliases.nix";
    me = "cd /run/media/$USER";
    ne = "cd $HOME/.config/nvim";
    de = "cd $HOME/dev";
    ho = "cd $HOME/home-manager/$USER";
    co = "cd $HOME/.config";

    # ______________________________________ NIXOS

    ns = "sudo nixos-rebuild switch --flake $HOME/nixos#$USER";
    nb = "sudo nixos-rebuild boot --flake $HOME/nixos#$USER";
    nu = "__update_flake_inputs $HOME/nixos";
    nv = "nixos-version";
    ni = "nix-info -m";
    ng = "sudo nix-collect-garbage -d";
    ngd = "nix-env --delete-generations +10";
    ngl = "nix-env --list-generations";
    store = "cd /nix/store && __open_file";

    # ______________________________________ NIX

    nr = "nix run";
    nd = "read -p 'nix develop $HOME#' devShellName && nix develop $HOME#$devShellName";

    # ______________________________________ FLAKE

    fl = "nix flake lock";
    fs = "nix flake show";
    fu = "nix flake update";
    fm = "nix flake metadata";
    fp = "nix flake metadata --json | jq .path";
    ft = "__use_flake_template $HOME/templates";

    # ______________________________________ HOME MANAGER

    hs = "home-manager switch --flake $HOME/home-manager";
    hu = "__update_flake_inputs $HOME/home-manager";
    hv = "home-manager --version";
    hps = "home-manager packages | fzf --inline-info";

    # ______________________________________ QMK

    qc = "(cd $HOME/.config/qmk && qmk compile -kb ferris/sweep -km Runeword)";
    qfl = "(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-left)";
    qfr = "(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-right)";
    qcd = "cd $HOME/.config/qmk/qmk_firmware/keyboards/ferris/keymaps/Runeword";
    qd = "(cd $HOME/.config/qmk && qmk generate-compilation-database -kb ferris/sweep -km Runeword)";

    # ______________________________________ CHEZMOI

    chd = "chezmoi diff --reverse";
    chi = "chezmoi ignored";
    chc = "chezmoi cd";

    # ______________________________________ GO

    gog = "go get";
    gor = "go run";
    gom = "go mod tidy";
    goc = "go clean -modcache";
    got = "go test";
    gob = "go build";

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
