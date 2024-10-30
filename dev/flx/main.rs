use std::process::Command;
use std::io::{self, Write};
use serde_json::Value;
use tui::{
    backend::CrosstermBackend,
    widgets::{Block, Borders, List, ListItem, Paragraph, ListState, Wrap},
    layout::{Layout, Constraint, Direction},
    style::{Color, Modifier, Style},
    text::{Span, Spans},
    Terminal,
};
use crossterm::{
    event::{self, DisableMouseCapture, EnableMouseCapture, Event, KeyCode},
    execute,
    terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen},
};

fn fuzzy_match(pattern: &str, text: &str) -> bool {
    let pattern = pattern.to_lowercase();
    let text = text.to_lowercase();
    let mut text_chars = text.chars();
    pattern.chars().all(|p| text_chars.any(|t| t == p))
}

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

    // Setup terminal
    enable_raw_mode()?;
    let mut stdout = io::stdout();
    execute!(stdout, EnterAlternateScreen, EnableMouseCapture)?;
    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    let mut selected = 0;
    let mut list_state = ListState::default();
    list_state.select(Some(selected));
    let mut search_query = String::new();
    let mut filtered_inputs: Vec<String> = inputs.clone();

    loop {
        terminal.draw(|f| {
            let chunks = Layout::default()
                .direction(Direction::Vertical)
                .constraints([Constraint::Length(3), Constraint::Min(0)].as_ref())
                .split(f.size());

            let search_input = Paragraph::new(search_query.as_ref())
                .style(Style::default().fg(Color::Yellow))
                .block(Block::default().borders(Borders::ALL).title("Search"));
            f.render_widget(search_input, chunks[0]);

            let inner_chunks = Layout::default()
                .direction(Direction::Horizontal)
                .constraints([Constraint::Percentage(30), Constraint::Percentage(70)].as_ref())
                .split(chunks[1]);

            let items: Vec<ListItem> = filtered_inputs
                .iter()
                .map(|i| ListItem::new(i.as_str()))
                .collect();

            let list = List::new(items)
                .block(Block::default().title("Inputs").borders(Borders::ALL))
                .highlight_style(Style::default().add_modifier(Modifier::REVERSED))
                .highlight_symbol("> ");

            f.render_stateful_widget(list, inner_chunks[0], &mut list_state);

            let input_info = if let Some(input) = filtered_inputs.get(selected) {
                let input_data = &flake_metadata["locks"]["nodes"][input];
                let mut info = String::new();
                info.push_str(&format!("Input: {}\n\n", input));
                
                if let Some(original) = input_data["original"].as_object() {
                    info.push_str("Original:\n");
                    for (key, value) in original {
                        info.push_str(&format!("  {}: {}\n", key, value));
                    }
                    info.push('\n');
                }
                
                if let Some(locked) = input_data["locked"].as_object() {
                    info.push_str("Locked:\n");
                    for (key, value) in locked {
                        info.push_str(&format!("  {}: {}\n", key, value));
                    }
                    info.push('\n');
                }
                
                if let Some(flake) = input_data["flake"].as_bool() {
                    info.push_str(&format!("Flake: {}\n", flake));
                }
                
                info
            } else {
                String::new()
            };

            let preview = Paragraph::new(input_info)
                .block(Block::default().title("Preview").borders(Borders::ALL))
                .wrap(Wrap { trim: true });

            f.render_widget(preview, inner_chunks[1]);
        })?;

        if let Event::Key(key) = event::read()? {
            match key.code {
                KeyCode::Char('q') => break,
                KeyCode::Down => {
                    selected = (selected + 1) % filtered_inputs.len();
                    list_state.select(Some(selected));
                },
                KeyCode::Up => {
                    selected = (selected + filtered_inputs.len() - 1) % filtered_inputs.len();
                    list_state.select(Some(selected));
                },
                KeyCode::Enter => {
                    if let Some(input) = filtered_inputs.get(selected) {
                        println!("Updating input: {}", input);
                        let status = Command::new("nix")
                            .args(&["flake", "lock", "--update-input", input, flake_path])
                            .status()?;

                        if !status.success() {
                            eprintln!("Failed to update input: {}", input);
                        }
                    }
                },
                KeyCode::Char(c) => {
                    search_query.push(c);
                    filtered_inputs = inputs.iter()
                        .filter(|input| fuzzy_match(&search_query, input))
                        .cloned()
                        .collect();
                    selected = 0;
                    list_state.select(Some(selected));
                },
                KeyCode::Backspace => {
                    search_query.pop();
                    filtered_inputs = inputs.iter()
                        .filter(|input| fuzzy_match(&search_query, input))
                        .cloned()
                        .collect();
                    selected = 0;
                    list_state.select(Some(selected));
                },
                _ => {}
            }
        }
    }

    // Restore terminal
    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture
    )?;
    terminal.show_cursor()?;

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
