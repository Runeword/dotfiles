#!/bin/sh

# This function prompts the user to select one or more inputs from a specified Nix flake
# then updates the selected inputs.
# It exits the function if there are no inputs or no inputs are selected.
__update_flake_inputs() {
	local flake_path=$1
	local flake_metadata=$(nix flake metadata "$flake_path" --json)

	local inputs=$(echo "$flake_metadata" | jq --raw-output '.locks.nodes.root.inputs | keys[]')
	[ -z "$inputs" ] && return 1

	local selected_inputs=$(
		echo "$inputs" | fzf \
			--multi --inline-info --reverse --no-separator --border none --cycle --height 70% \
			--preview "echo '$flake_metadata' | jq --color-output '.locks.nodes.\"{}\"'" \
			--preview-window right,75%,noborder
	)
	[ -z "$selected_inputs" ] && return 1

	for i in $selected_inputs; do
		nix flake lock --update-input "$i" "$flake_path"
	done
}

# "dir": "contrib", "owner": "sourcegraph", "repo": "src-cli", "type": "github" type:owner/repo?dir=dir

# This function allows the user to select a template from a specified Nix flake
# then adds the template to .envrc so direnv can load it.
# It exits the function if there are no templates or no template is selected.
__use_flake_template() {
	local flake_path=$1

	local templates=$(nix flake show "$flake_path" --json | jq --raw-output '.templates | keys[]')
	[ -z "$templates" ] && return 1

	# --no-info --cycle \
	local selected_template=$(
		echo "$templates" | fzf \
			--multi --inline-info --reverse --no-separator --border none --cycle --height 70% \
			--preview "bat --style=plain --color=always $(nix flake metadata $flake_path --json | jq -r .path)/{}/flake.nix" \
			--preview-window right,80%,noborder
	)
	[ -z "$selected_template" ] && return 1

	echo "use flake \"$flake_path/$selected_template\"" >>.envrc
	direnv allow
}

# templates=$(nix flake metadata "$flake_path" --json | jq -r .path)
# --preview '[ -f {} ] && bat --style=plain --color=always {}' \
# chezmoi diff --reverse --color=true
# nix-instantiate --parse templates/firebase/flake.nix | bat --language=nix
# cat templates/firebase/flake.nix | bat --language nix
# "nix flake update $HOME/flake"; # update all inputs
# github:Runeword/dotfiles?dir=flake/
# github:Runeword/dotfiles?dir=templates/$template
