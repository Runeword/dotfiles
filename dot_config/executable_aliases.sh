# ______________________________________ NIXOS

alias ns="sudo nixos-rebuild switch --flake $HOME/nixos#$USER"
alias nsp='nix-env --switch-profile $(ls /nix/var/nix/profiles/per-user/$USER | fzf)'
alias nb='sudo nixos-rebuild boot --flake $HOME/nixos#$USER'
alias nu='__update_flake_inputs $HOME/nixos'
alias nv='nixos-version'
alias ni='nix-info -m'
alias ng='sudo nix-collect-garbage --delete-old --verbose'
alias ngd='nix-env --delete-generations +10'
alias ngl='nix-env --list-generations'
alias store='cd /nix/store && __open_file'

# # ______________________________________ NIX

alias nr='nix run'
alias nd="read -p 'nix develop $HOME#' devShellName && nix develop $HOME#$devShellName"

# # ______________________________________ FLAKE

alias fl='rm -f flake.lock && nix flake lock'
alias fs='nix flake show'
alias fu='nix flake update'
alias fm='nix flake metadata'
alias fp='nix flake metadata --json | jq .path'
alias ft='__use_flake_template $HOME/templates'

# # ______________________________________ HOME MANAGER

alias hs="home-manager switch --flake $HOME/home-manager"
alias hu="__update_flake_inputs $HOME/home-manager"
alias hv="home-manager --version"
alias hpk="home-manager packages | fzf --inline-info"

# ______________________________________ DIRECTORIES

alias ne="cd $HOME/.config/nvim"
alias de="cd $HOME/dev"
alias ho="cd $HOME/home-manager/$USER"
alias co="cd $HOME/.config"
alias dw="cd $HOME/Downloads && yazi"
# alias pr= "cd .nix-profile"

# ______________________________________ FILES

alias np="nvim $HOME/nixos/configuration.nix"
alias nf="nvim $HOME/nixos/flake.nix"
alias hp="nvim $HOME/home-manager/$USER/packages.nix"
alias hd="nvim $HOME/home-manager/$USER/default.nix"
alias hf="nvim $HOME/home-manager/flake.nix"
alias ov="nvim $HOME/home-manager/$USER/overlays.nix"
alias al="nvim $HOME/home-manager/$USER/aliases.nix"
alias va="nvim $HOME/home-manager/$USER/sessionVariables.nix"
alias zs="nvim $HOME/home-manager/$USER/zshrc"

# ______________________________________ CHEZMOI

alias chd="chezmoi diff --reverse"
alias chi="chezmoi ignored"
alias chc="chezmoi cd"
alias chr="chezmoi --refresh-externals apply"
alias cha="__chezmoi_add"
alias chy="__chezmoi_apply"
alias chf="__chezmoi_forget"
alias ch="__chezmoi_edit"

# ______________________________________ GIT

alias g="lazygit"
alias gi="onefetch"
alias gn='git status -s | awk "{print \$2}" | xargs -r nvim'
alias gs="git status"
alias gpl="git pull"
alias gp="git push"
alias gpo="git push origin"
alias gt="git-forgit stash_push"       # git stash push
alias gtl="git-forgit stash_show"      # git stash list
alias gty="git stash apply"
alias gd="git-forgit diff"             # git diff
alias gdc="git diff --cached"
alias ga="git-forgit add"              # git add
alias gl="git-forgit log"              # git log
alias gb="git branch"
alias gbd="git-forgit branch_delete"   # git branch -d
alias gbl="git-forgit blame"           # git blame
alias gk="git checkout"
alias gk-="git checkout --"
alias gkb="git-forgit checkout_branch" # git checkout
alias gkf="git-forgit checkout_file"   # git checkout
alias gct="git-forgit checkout_tag"    # git checkout
alias gco="git-forgit checkout_commit" # git checkout
alias gc="git commit"
alias gcl="git clone"
alias gcp="git-forgit cherry_pick"     # git cherry-pick
alias gm="git merge"
alias grb="git-forgit rebase"          # git rebase
alias gr="git reset"
alias grh="git-forgit reset_head"      # git reset
# alias grh="git reset HEAD~1"
alias gwa="git worktree add"
alias gwl="git worktree list"
alias gwr="git worktree remove"

# ______________________________________ GO

alias gog="go get"
alias gor="go run"
alias gom="go mod tidy"
alias goc="go clean -modcache"
alias got="go test"
alias gob="go build"

# ______________________________________ NPM

alias npl="npm ls --depth=0"
alias npg="npm ls -g --depth=0"
alias npd="npm run dev"
alias npi="npm i"

# ______________________________________ QMK

alias qc="(cd $HOME/.config/qmk && qmk compile -kb ferris/sweep -km Runeword)"
alias qfl="(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-left)"
alias qfr="(cd $HOME/.config/qmk && qmk flash -kb ferris/sweep -km Runeword -bl dfu-split-right)"
alias qcd="cd $HOME/.config/qmk/qmk_firmware/keyboards/ferris/keymaps/Runeword"
alias qd="(cd $HOME/.config/qmk && qmk generate-compilation-database -kb ferris/sweep -km Runeword)"
