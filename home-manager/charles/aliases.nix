{
  home.shellAliases = {
    # up = "up(){ realesrgan-ncnn-vulkan -i \"$1\" -o output.png; }; up";
    # xc = "xclip -selection c";
    # xp = "xclip -selection c -o";
    # b = "br"; # :open_preview
    # w = "waypaper";
    # hhp = "hyprctl hyprpaper preload";
    # hhw = "hyprctl hyprpaper wallpaper";
    # color = "colorpicker"; # X11
    # sin = "$HOME/.screenlayout/single.sh && feh --bg-fill $HOME/.config/Skin\ The\ Remixes.png";
    # dua = "$HOME/.screenlayout/dual.sh";
    # l = "exa --all --group-directories-first --sort=time";
    # ll = ''
    # exa --long --all --color=always --octal-permissions --group-directories-first --sort=time | \
    # fzf --ansi --multi --delimiter : --reverse --border none --cycle --info=inline:"" --height 70% --no-separator
    # '';
    # ll = "exa --long --all --octal-permissions --group-directories-first --total-size --sort=time";
    # bb = "br -c ':toggle_hidden;:toggle_perm;:toggle_dates'";

    # ______________________________________ UTILITY

    play = "asciinema play";
    "rec" = "asciinema rec $HOME/Downloads/$(date +'%Y-%m-%d_%H-%M-%S').cast";
    keys = "showkey -a";
    color = "hyprpicker --autocopy --format=hex";
    bios = "sudo dmidecode -s bios-version";
    window = "xprop WM_CLASS";
    progress = "watch progress -q";
    aliases = "__run_alias";
    hardware = "hwinfo --short";
    system = "neofetch";
    wallpaper = "__wallpaper";
    fonts = "fc-list : family style | fzf --reverse --prompt='  ' --info=inline:'' --no-separator --height 70%";
    path = "echo \"\${PATH//:/\\n}\"";
    devices = "sudo libinput list-devices";
    monitors = "hyprctl monitors";
    clients = "hyprctl clients";
    keyboard = "pgrep -x evtest > /dev/null && sudo pkill evtest || sudo setsid evtest --grab /dev/input/event1 > /dev/null 2>&1";
    pk = "sudo pkill";
    # pg = "pgrep -x";
    btm = "command btm --tree --left_legend";
    procs = "command procs --tree";
    disk = "duf";
    # disk = "lsblk";
    # diskinfo = "sudo nvme smart-log /dev/nvme0n1";
    audit = "lynis audit system";
    # fcount = ''find . -type d -exec sh -c 'echo -n "$1, "; find "$1" -maxdepth 1 -type f | wc -l' _ {} \; | awk -F, '$2 > 500''';

    # ______________________________________ PROGRAM

    gparted = "sudo -E gparted";
    ventoy = "sudo ventoy-web";
    chrome = "google-chrome-stable";
    cheat = "navi --cheatsh";
    tldr = "navi --tldr";
    n = "nvim";

    me = ''
      __open_device() {
        local devices
        devices=$(ls /run/media/"$USER")
        if [ "$devices" = "" ]; then return 0; fi
        local device
        device=$(echo "$devices" | fzf --reverse --info=hidden --prompt='  ' --no-separator --height 70% --header="C-u unmount device" --header-first --bind='ctrl-u:reload-sync(umount /run/media/"$USER"/{})')
        if [ "$device" = "" ]; then return 0; fi
        cd "/run/media/$USER/$device" || return 0
      }
      __open_device
    '';
  };
}
