local vim = vim

return {
  'inside/vim-search-pulse',

  config = function()
    vim.g.vim_search_pulse_duration = 200
    vim.g.vim_search_pulse_mode = 'pattern'
    vim.g.vim_search_pulse_disable_auto_mappings = 1

    vim.keymap.set('n', 'n', 'n<Plug>Pulse', { remap = true, })
    vim.keymap.set('n', 'N', 'N<Plug>Pulse', { remap = true, })
    -- vim.keymap.set('n', '*', '*<Plug>Pulse', { remap = true, })
    -- vim.keymap.set('n', '#', '#<Plug>Pulse', { remap = true, })
    vim.keymap.set('c', '<Enter>', 'search_pulse#PulseFirst()',
      { silent = true, expr = true, })
  end,
}
