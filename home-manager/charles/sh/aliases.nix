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
    r = "gomi -rf";
    ru = "gomi --restore";
    rd = "rm -rf $HOME/.gomi";
    o = "__open_file";
    s = "__ripgrep";
    i = "kitten icat";
    w = "__wallpaper";
    p = "hyperfine";
    z = "__zellij";
    zn = "zellij";
    a = ''eval "$(alias | fzf --delimiter='=' --bind "enter:execute(echo {2} | tr -d \"'\")+abort")"'';
    ".." = "cd ..";
    "..." = "cd ../..";
    ss = "src search";
    xc = "xclip -selection c";
    xp = "xclip -selection c -o";
    hm = "hyprctl monitors";
    hhp = "hyprctl hyprpaper preload";
    hhw = "hyprctl hyprpaper wallpaper";
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

    # ______________________________________ NIX
    hs = "home-manager switch --flake $HOME/home-manager";
    hu = "__update_flake_inputs $HOME/home-manager";
    hp = "home-manager packages | fzf --inline-info";
    store = "cd /nix/store && __open_file";
    ns = "sudo nixos-rebuild switch --flake $HOME/nixos#$USER";
    ni = "nix-info -m";
    nb = "sudo nixos-rebuild boot --flake $HOME/nixos#$USER";
    nd = "read -p 'nix develop $HOME#' devShellName && nix develop $HOME#$devShellName";
    nu = "__update_flake_inputs $HOME/nixos";
    nt = "__use_flake_template $HOME/templates";
    nl = "nix flake lock";
    nw = "nix flake show";
    # nt = "printf 'Enter the template name: ' >&2 && read templateName && nix flake new --template $HOME/templates#$templateName";
    nfm = "nix flake metadata";
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
