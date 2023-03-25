local wezterm = require 'wezterm'

return {
  font = wezterm.font('Hack Nerd Font'),
  font_size = 20.0,
  disable_default_key_bindings = true,
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = 'default',
  default_cursor_style = 'BlinkingBar',
  window_background_opacity = 0.7,
}
