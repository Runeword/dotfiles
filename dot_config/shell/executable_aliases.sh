# ______________________________________ CORE

alias shn='shutdown now'
alias s='setsid'
alias mv='mv --verbose'
alias rmdir='rmdir --verbose'
alias mkdir='mkdir --parents --verbose'
alias md='mkdir --parents --verbose'
alias cp='cp --recursive --verbose'
alias pwd='command pwd | tee /dev/tty | wl-copy'
alias cd='__cd'
alias ..='cd ..'
alias ...='cd ../..'
# alias cd='__zoxide_z'
# alias cdh='__zoxide_zi'
# alias l='command ls --almost-all --color --width 90'
alias l='command ls -lt --almost-all --color --human-readable --classify | fzf --ansi --multi --delimiter : --reverse --border none --cycle --info=inline:"" --prompt="  " --height 70% --no-separator --header-lines=1'
alias i='setsid satty --copy-command "wl-copy" --early-exit --init-tool brush --output-filename ~/Downloads/$(date +"%Y-%m-%d_%H-%M-%S").png --filename'
alias xd='xdg-mime default'
alias f='fzf --reverse --cycle --prompt=" " --height 70% --no-separator --info=inline:""'
# alias c='!! | wl-copy'
alias c='wl-copy'
alias p='wl-paste'
alias me='__open_device'

# ______________________________________ UTILITY

alias play='asciinema play'
alias rec='asciinema rec $HOME/Downloads/$(date +"%Y-%m-%d_%H-%M-%S").cast'
alias keys="showkey -a"
alias color="hyprpicker --autocopy --format=hex"
alias bios="sudo dmidecode -s bios-version"
alias window="xprop WM_CLASS"
alias progress="watch progress -q"
alias aliases="__run_alias"
alias hardware="hwinfo --short"
alias system="neofetch"
alias wallpaper="__wallpaper"
alias fonts='fc-list : family style | fzf --reverse --prompt="  " --info=inline:"" --no-separator --height 70%'
alias path='echo "$PATH" | tr ":" "\n"'
alias devices='sudo libinput list-devices'
alias monitors='hyprctl monitors'
alias clients='hyprctl clients'
alias keyboard='pgrep -x evtest > /dev/null && sudo pkill evtest || sudo setsid evtest --grab /dev/input/event1 > /dev/null 2>&1'
alias pk='sudo pkill'
# alias pg='pgrep -x'
alias btm='command btm --tree --left_legend'
alias procs='command procs --tree'
alias disk='duf'
# alias disk='lsblk'
# alias diskinfo = 'sudo nvme smart-log /dev/nvme0n1'
alias audit='lynis audit system'
# alias fcount='find . -type d -exec sh -c '\''echo -n "$1, "; find "$1" -maxdepth 1 -type f | wc -l'\'' _ {} \; | awk -F, '\''$2 > 500'\'''

# ______________________________________ NIXOS

alias ns='sudo nixos-rebuild switch --flake $HOME/nixos#$USER'
alias nsp='nix-env --switch-profile $(ls /nix/var/nix/profiles/per-user/$USER | fzf)'
alias nb='sudo nixos-rebuild boot --flake $HOME/nixos#$USER'
alias nu='__update_flake_inputs $HOME/nixos'
alias nv='nixos-version'
alias ni='nix-info -m'
alias ng='sudo nix-collect-garbage --delete-old --verbose'
alias ngd='nix-env --delete-generations +10'
alias ngl='nix-env --list-generations'
alias store='cd /nix/store && __open_file'

# ______________________________________ NIX

alias nr='nix run'
alias nd='read -p "nix develop $HOME#" devShellName && nix develop $HOME#$devShellName'

# ______________________________________ FLAKE

alias fl='rm -f flake.lock && nix flake lock'
alias fs='nix flake show'
alias fu='nix flake update'
alias fm='nix flake metadata'
alias fp='nix flake metadata --json | jq .path'
alias ft='__use_flake_template $HOME/templates'

# ______________________________________ HOME MANAGER

alias hs='home-manager switch --flake $HOME/home-manager'
alias hu='__update_flake_inputs $HOME/home-manager'
alias hv='home-manager --version'
alias hpk='home-manager packages | fzf --inline-info'

# ______________________________________ DIRECTORIES

alias ne='cd $HOME/.config/nvim'
alias de='cd $HOME/dev'
alias ho='cd $HOME/home-manager/$USER'
alias co='cd $HOME/.config'
alias dw='cd $HOME/Downloads && yazi'
alias st='cd /nix/store'
# alias pr= 'cd .nix-profile'

# ______________________________________ FILES

alias np='nvim $HOME/nixos/configuration.nix'
alias nf='nvim $HOME/nixos/flake.nix'
alias hp='nvim $HOME/home-manager/$USER/packages.nix'
alias hd='nvim $HOME/home-manager/$USER/default.nix'
alias hf='nvim $HOME/home-manager/flake.nix'
alias ov='nvim $HOME/home-manager/$USER/overlays.nix'
alias zs='nvim $HOME/home-manager/$USER/zshrc'
alias al='nvim $HOME/.config/shell/aliases.sh'
alias va='nvim $HOME/.config/shell/variables.sh'

# ______________________________________ CHEZMOI

alias chd="chezmoi diff --reverse"
alias chi='chezmoi ignored'
alias chc='chezmoi cd'
alias chr='chezmoi --refresh-externals apply'
alias cha='__chezmoi_add'
alias chy='__chezmoi_apply'
alias chf='__chezmoi_forget'
alias ch='__chezmoi_edit'

# ______________________________________ GIT

alias g='lazygit'
alias gi='onefetch'
# alias gn='git status -s | awk "{print \$2}" | xargs -r nvim'
alias gs='git status'
alias gpl='git pull'
alias gp='git push'
alias gpo='git push origin'
alias gt='git-forgit stash_push'       # git stash push
alias gtl='git-forgit stash_show'      # git stash list
alias gty='git stash apply'
alias gd='git-forgit diff'             # git diff
alias gdc='git diff --cached'
alias ga='git-forgit add'              # git add
alias gl='git-forgit log'              # git log
alias gb='git branch'
alias gbd='git-forgit branch_delete'   # git branch -d
alias gbl='git-forgit blame'           # git blame
alias gk='git checkout'
alias gk-='git checkout --'
alias gkb='git-forgit checkout_branch' # git checkout
alias gkf='git-forgit checkout_file'   # git checkout
alias gct='git-forgit checkout_tag'    # git checkout
alias gco='git-forgit checkout_commit' # git checkout
alias gc='git commit'
alias gcl='git clone'
alias gcp='git-forgit cherry_pick'     # git cherry-pick
alias gm='git merge'
alias grb='git-forgit rebase'          # git rebase
alias gr='git reset'
alias grh='git-forgit reset_head'      # git reset
# alias grh='git reset HEAD~1'
alias gwa='git worktree add'
alias gwl='git worktree list'
alias gwr='git worktree remove'

# ______________________________________ PASS

alias pp='pass git push'
alias pi='pass insert'
alias pg='pass generate'
alias pl='__pass_clip'
alias pc='__pass_clip'
alias pr='__pass_rm'

# ______________________________________ GO

alias gog='go get'
alias gor='go run'
alias gom='go mod tidy'
alias goc='go clean -modcache'
alias got='go test'
alias gob='go build'

# ______________________________________ NPM

alias npl='npm ls --depth=0'
alias npg='npm ls -g --depth=0'
alias npd='npm run dev'
alias npi='npm i'

# ______________________________________ QMK

alias qc='(cd $HOME/.config/qmk && qmk compile -kb ferris/sweep -km Runeword)'
alias qfl='(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-left)'
alias qfr='(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-right)'
alias qcd='cd $HOME/.config/qmk/qmk_firmware/keyboards/ferris/keymaps/Runeword'
alias qd='(cd $HOME/.config/qmk && qmk generate-compilation-database -kb ferris/sweep -km Runeword)'

# ______________________________________ NETWORK

alias b='bluetuith'
alias bl='__bluetoothctl'
alias w='__nmcli'
alias wo='nmcli radio wifi on'
alias wf='nmcli radio wifi off'

# ______________________________________ TRASH

alias r='gomi -rf'
alias ru='gomi --restore'
alias rd='rm -rfv $HOME/.gomi'
alias rt='rm -rfv $HOME/.local/share/Trash/files'

# ______________________________________ ARCHIVE

alias od='ouch decompress'
alias oc='ouch compress'
alias ol='ouch list'

# ______________________________________ PROGRAMS

alias gparted='sudo -E gparted'
alias ventoy='sudo ventoy-web'
alias chrome='google-chrome-stable'
alias cheat='navi --cheatsh'
alias tldr='navi --tldr'
alias n='nvim'

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
