#!/bin/sh

# This function prompts the user to select one or more inputs from a specified Nix flake
# then updates the selected inputs.
# It exits the function if there are no inputs or no inputs are selected.
nfu () {
  flake_path=${1-$HOME/flake}

  inputs=$(nix flake metadata "$flake_path" --json | jq -r '.locks.nodes.root.inputs | keys[]')
  [ -z "$inputs" ] && return 1

  selected_inputs=$(echo "$inputs" | fzf --multi --no-info --cycle)
  [ -z "$selected_inputs" ] && return 1

  for i in $selected_inputs; do
    nix flake lock --update-input "$i" "$flake_path"
  done
}

# This function allows the user to select a template from a specified Nix flake
# then adds the template to .envrc so direnv can load it.
# It exits the function if there are no templates or no template is selected.
ne () {
  flake_path=${1-$HOME/templates}

  templates=$(nix flake show "$flake_path" --json | jq -r '.templates | keys[]')
  [ -z "$templates" ] && return 1

  selected_template=$(echo "$templates" | fzf --no-info --cycle)
  [ -z "$selected_template" ] && return 1

  echo "use flake \"$flake_path/$selected_template\"" >> .envrc
  direnv allow
}

# "nix flake update $HOME/flake"; # update all inputs
# github:Runeword/dotfiles?dir=flake/
# github:Runeword/dotfiles?dir=templates/$template
