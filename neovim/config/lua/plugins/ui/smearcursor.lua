return {
  'sphamba/smear-cursor.nvim',

  event = 'VeryLazy',

  init = function()
    require('smear_cursor').setup({
      cursor_color = '#d3cdc3',
      normal_bg = '#282828',
      smear_between_buffers = false,
      smear_between_neighbor_lines = false,
      use_floating_windows = false,
      legacy_computing_symbols_support = false,
      hide_target_hack = true,
    })
  end,
}
