#!/bin/sh

# This function prompts the user to select one or more inputs from a specified Nix flake
# then updates the selected inputs.
# It exits the function if there are no inputs or no inputs are selected.
nfu () {
  # Set the variable "flake_path" to the first argument, or the default value if it's not provided
  flake_path=${1-$HOME/flake}

  # Get the list of inputs for the flake at "$flake_path" using "nix flake metadata" and "jq"
  inputs=$(nix flake metadata "$flake_path" --json | jq -r '.locks.nodes.root.inputs | keys[]')

  [ -z "$inputs" ] && return 1

  # Use "fzf" to select one or more inputs from the list
  selected_inputs=$(echo "$inputs" | fzf --multi --no-info --cycle)

  [ -z "$selected_inputs" ] && return 1

  # Iterate through the selected inputs and update them using "nix flake lock --update-input"
  for i in $selected_inputs; do
    nix flake lock --update-input "$i" "$flake_path"
  done
}

# This function allows the user to select a template from a specified Nix flake
# then adds the template to .envrc so direnv can load it.
# It exits the function if there are no templates or no template is selected.
ne () {
  # Replace $HOME/templates with the first argument (or use $HOME/templates if no argument is given)
  flake_path=${1-$HOME/templates}

  # Get the list of available templates from the Nix flake
  templates=$(nix flake show "$flake_path" --json | jq -r '.templates | keys[]')

  # Exit the function if there are no templates
  [ -z "$templates" ] && return 1

  # Use fzf to select a template from the list
  selected_template=$(echo "$templates" | fzf --no-info --cycle)

  # Exit the function if no template is selected
  [ -z "$selected_template" ] && return 1

  # Add template to .envrc
  echo "use flake \"$flake_path/$selected_template\"" >> .envrc

  # Allow the changes to take effect using direnv
  direnv allow
}

# "nix flake update $HOME/flake"; # update all inputs
# github:Runeword/dotfiles?dir=flake/
# github:Runeword/dotfiles?dir=templates/$template
