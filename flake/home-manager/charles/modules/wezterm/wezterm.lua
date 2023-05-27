local wezterm = require 'wezterm'

return {
  font = wezterm.font('Hack Nerd Font'),
  font_size = 21.0,
  disable_default_key_bindings = true,
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = 'default',
  default_cursor_style = 'BlinkingBar',
  cursor_blink_rate = 500,
  window_background_opacity = 0.7,
  keys = {
    { key = 'C', mods = 'CTRL', action = wezterm.action.CopyTo('Clipboard'), },
    { key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom('Clipboard') },
    { key = '+', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
    { key = '=', mods = 'CTRL', action = wezterm.action.ResetFontSize },
    { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
    { key = 'Home', action = wezterm.action.ScrollToTop },
    { key = 'End', action = wezterm.action.ScrollToBottom },
  },
}
