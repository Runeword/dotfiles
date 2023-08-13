{
  home.shellAliases = {
    # up = "up(){ realesrgan-ncnn-vulkan -i \"$1\" -o output.png; }; up";
    shn = "shutdown now";
    chrome = "google-chrome-stable";
    # color = "colorpicker"; # X11
    win = "xprop WM_CLASS";
    # sin = "$HOME/.screenlayout/single.sh && feh --bg-fill $HOME/.config/Skin\ The\ Remixes.png";
    # dua = "$HOME/.screenlayout/dual.sh";
    wa = "watch progress -q";
    mv = "mv --verbose";
    md = "mkdir --parents";
    cp = "cp --recursive --verbose";
    # b = "br"; # :open_preview
    bb = "br -c ':toggle_hidden;:toggle_perm;:toggle_dates'";
    bt = "__bluetoothctl";
    b = "bluetuith";
    l = "command ls --almost-all --color --width 90";
    ll = "command ls -lt --almost-all --color --human-readable --classify";
    n = "nvim";
    r = "trash";
    o = "__open_file";
    s = "__ripgrep";
    i = "kitten icat";
    ".." = "cd ..";
    "..." = "cd ../..";
    ss = "src search";
    a = "alias | fzf";
    xc = "xclip -selection c";
    xp = "xclip -selection c -o";
    hm = "hyprctl monitors";
    hhp = "hyprctl hyprpaper preload";
    hhw = "hyprctl hyprpaper wallpaper";
    play = "asciinema play";
    "rec" = "asciinema rec $HOME/Downloads/$(date +'%Y-%m-%d_%H-%M-%S').cast";
    key = "showkey -a";
    p = "hyperfine";
    c = "hyprpicker --autocopy --format=hex";
    w = "__wallpaper";
    cheat = "navi --cheatsh";
    tldr = "navi --tldr";

    # ______________________________________ NIX
    hs = "home-manager switch --flake $HOME/home-manager";
    hp = "home-manager packages | fzf --inline-info";
    store = "cd /nix/store && __open_file";
    ns = "sudo nixos-rebuild switch --flake $HOME/nixos#charles";
    ni = "nix-info -m";
    nb = "sudo nixos-rebuild boot --flake $HOME/nixos#charles";
    nd = "read -p 'nix develop $HOME#' devShellName && nix develop $HOME#$devShellName";
    nfu = "__update_flake_inputs $HOME";
    nft = "__use_flake_template $HOME/templates";
    nfi = "read -p 'nix flake init -t $HOME/templates#' templateName && nix flake init -t $HOME/templates#$templateName";
    nfs = "nix flake show";
    nfl = "nix flake lock";
    nr = "nix run";
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

    # ______________________________________ NPM
    npl = "npm ls --depth=0";
    npg = "npm ls -g --depth=0";
    npd = "npm run dev";
    npi = "npm i";
  };
}
