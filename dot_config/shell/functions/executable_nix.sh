#!/bin/sh

# This function prompts the user to select one or more inputs from a specified Nix flake
# then updates the selected inputs.
# It exits the function if there are no inputs or no inputs are selected.
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
			--multi --info=inline:'' --reverse --no-separator --prompt='  ' --border none --cycle --height 70% \
			--preview "echo '$flake_metadata' | jq --color-output '.locks.nodes.\"{}\"'" \
			--preview-window right,75%,noborder
	)
	[ -z "$selected_inputs" ] && return 1

	for i in $(echo "$selected_inputs" | xargs); do
		nix flake lock --update-input "$i" "$flake_path"
	done
}

# "dir": "contrib", "owner": "sourcegraph", "repo": "src-cli", "type": "github" type:owner/repo?dir=dir

# This function allows the user to select a template from a specified Nix flake
# then adds the template to .envrc so direnv can load it.
# It exits the function if there are no templates or no template is selected.
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

	echo "use flake \"$flake_path/$selected_template\"" >>.envrc
	direnv allow
}

__home_manager_packages() {
    local selected package full_path

    selected=$(home-manager packages | fzf --info=inline:'' --reverse --no-separator --prompt='  ' --border none) || return

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

# templates=$(nix flake metadata "$flake_path" --json | jq -r .path)
# --preview '[ -f {} ] && bat --style=plain --color=always {}' \
# chezmoi diff --reverse --color=true
# nix-instantiate --parse templates/firebase/flake.nix | bat --language=nix
# cat templates/firebase/flake.nix | bat --language nix
# "nix flake update $HOME/flake"; # update all inputs
# github:Runeword/dotfiles?dir=flake/
# github:Runeword/dotfiles?dir=templates/$template
