#!/bin/sh

# Prompts the user to select one or more inputs from a specified Nix flake
# then updates the selected inputs.
# It exits the function if there is no inputs or no inputs are selected.
__update_flake_inputs() {
	local flake_path="$1"
	local flake_metadata
	flake_metadata=$(nix flake metadata "$flake_path" --json)

	local inputs
	inputs=$(echo "$flake_metadata" | jq --raw-output '.locks.nodes.root.inputs | keys[]')
	[ -z "$inputs" ] && return 1

	local selected_inputs
	selected_inputs=$(
		echo "$inputs" | fzf \
			--multi --info=inline:'' --reverse --no-separator --prompt='  ' --border none --cycle --height 70% --header-first --bind='ctrl-a:select-all' --header="nix flake update"\
			--preview "echo '$flake_metadata' | jq --color-output '.locks.nodes.\"{}\"'" \
			--preview-window right,75%,noborder
	)
	[ -z "$selected_inputs" ] && return 1

	for i in $(echo "$selected_inputs" | xargs); do
		# nix flake update "$i" "$flake_path"
    nix flake lock --update-input "$i" "$flake_path"
	done
}

# Allows the user to select a template from a specified Nix flake
# then adds the template to .envrc so direnv can load it.
# It exits the function if there is no templates or no template is selected.
__use_flake_template() {
  local flake_path="$1"

  local templates
  templates=$(nix flake show "$flake_path" --json | jq --raw-output '.templates | keys[]')
  [ -z "$templates" ] && return 1

  # --no-info --cycle \
  local selected_template
  selected_template=$(
  echo "$templates" | fzf \
    --multi --info=inline:'' --reverse --no-separator --prompt='  ' --border none --cycle --height 70% \
    --preview "bat --style=plain --color=always $(nix flake metadata $flake_path --json | jq -r .path)/{}/flake.nix" \
    --preview-window right,80%,noborder
  )
  [ -z "$selected_template" ] && return 1

  nix flake init --template "$flake_path"/#"$selected_template"

  printf "use flake ." >> .envrc
  # echo "use flake \"$flake_path/$selected_template\"" >>.envrc
  if ! grep "^\.direnv/$" .gitignore > /dev/null 2>&1; then
    echo ".direnv/" >> .gitignore
  fi

  direnv allow
}

# Interactively selects a package from Home Manager and return its full path
__home_manager_packages() {
    local selected package full_path

    selected=$(home-manager packages | fzf --info=inline:'' --reverse --no-separator --prompt='  ' --border none --header-first --header="home-manager packages") || return

    package=$(echo "$selected" | awk '{print $1}' | sed 's/-[0-9].*//')
    echo "Selected package: $package"

    if ! full_path=$(command -v "$package"); then
        echo "Command '$package' not found in PATH"
    elif ! full_path=$(readlink -f "$full_path"); then
        echo "Could not resolve full path for $package"
    else
        echo "Full path: $full_path"
    fi
}

# Interactively selects and switch to a home manager generation
__home_manager_switch_generation() {
  local selected_generation

  selected_generation=$(
  home-manager generations \
    | fzf --info=inline:'' --reverse --no-separator --prompt='  ' --border none --cycle --height 70% --header-first --header="home-manager switch-generation" \
    | awk '{print $NF}' \
  )

  [ "$selected_generation" = "" ] && return 1

  eval "${selected_generation}/activate"
}

# Interactively selects and remove one or more home manager generations
__home_manager_remove_generations() {
  local selected_generations

  selected_generations=$(
  home-manager generations \
    | fzf --multi --info=inline:'' --reverse --no-separator --prompt='  ' --border none --cycle --height 70% --header-first --bind='ctrl-a:select-all' --header="home-manager remove-generations" \
    | awk '{print $5}'
  )

  [ "$selected_generations" = "" ] && return 1

  echo "$selected_generations" | xargs home-manager remove-generations
}

# Interactively selects and switch to a nixos generation
__nixos_switch_generation() {
  local nixos_generations selected_generation
  nixos_generations=$(sudo nix-env  --list-generations --profile /nix/var/nix/profiles/system | sort -rn)

  selected_generation=$(
  echo "$nixos_generations" \
    | fzf --info=inline:'' --reverse --no-separator --prompt='  ' --border none --cycle --height 70% --header-first --header="nix-env --profile /nix/var/nix/profiles/system --switch-generation <generation>" \
    | awk '{print $1}' \
  )

  [ "$selected_generation" = "" ] && return 1

  echo "Switching to generation $selected_generation"
  sudo /nix/var/nix/profiles/system-"$selected_generation"-link/bin/switch-to-configuration switch
}

# Interactively selects and remove one or more nixos generations
__nixos_remove_generations() {
  local nixos_generations selected_generations
  nixos_generations=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | sort -rn)

  selected_generations=$(
  echo "$nixos_generations" \
    | fzf --multi --info=inline:'' --reverse --no-separator --prompt='  ' --border none --cycle --height 70% --header-first --bind='ctrl-a:select-all' --header="nix-env -p /nix/var/nix/profiles/system --delete-generations <generations>" \
    | awk '{print $1}'
  )

  [ "$selected_generations" = "" ] && return 1

  echo "$selected_generations" | xargs sudo nix-env -p /nix/var/nix/profiles/system --delete-generations

  sudo /run/current-system/bin/switch-to-configuration boot
}

# "dir": "contrib", "owner": "sourcegraph", "repo": "src-cli", "type": "github" type:owner/repo?dir=dir
# templates=$(nix flake metadata "$flake_path" --json | jq -r .path)
# --preview '[ -f {} ] && bat --style=plain --color=always {}' \
# chezmoi diff --reverse --color=true
# nix-instantiate --parse templates/firebase/flake.nix | bat --language=nix
# cat templates/firebase/flake.nix | bat --language nix
# "nix flake update $HOME/flake"; # update all inputs
# github:Runeword/dotfiles?dir=flake/
# github:Runeword/dotfiles?dir=templates/$template
