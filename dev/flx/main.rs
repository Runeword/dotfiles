use std::process::Command;
use std::io::{self, Write};
use serde_json::Value;
use dialoguer::{MultiSelect, theme::ColorfulTheme};

fn update_flake_inputs(flake_path: &str) -> io::Result<()> {
    // Get flake metadata
    let output = Command::new("nix")
        .args(&["flake", "metadata", flake_path, "--json"])
        .output()?;

    let flake_metadata: Value = serde_json::from_slice(&output.stdout)?;

    // Extract inputs
    let inputs: Vec<String> = flake_metadata["locks"]["nodes"]["root"]["inputs"]
        .as_object()
        .map(|obj| obj.keys().cloned().collect())
        .unwrap_or_default();

    if inputs.is_empty() {
        println!("No inputs found.");
        return Ok(());
    }

    // Create MultiSelect for user to choose inputs
    let selections = MultiSelect::with_theme(&ColorfulTheme::default())
        .with_prompt("Select inputs to update")
        .items(&inputs)
        .interact()?;

    if selections.is_empty() {
        println!("No inputs selected.");
        return Ok(());
    }

    // Update selected inputs
    for &index in &selections {
        let input = &inputs[index];
        println!("Updating input: {}", input);
        let status = Command::new("nix")
            .args(&["flake", "lock", "--update-input", input, flake_path])
            .status()?;

        if !status.success() {
            eprintln!("Failed to update input: {}", input);
        }
    }

    Ok(())
}

fn main() -> io::Result<()> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        eprintln!("Usage: {} <flake_path>", args[0]);
        std::process::exit(1);
    }

    update_flake_inputs(&args[1])
}
