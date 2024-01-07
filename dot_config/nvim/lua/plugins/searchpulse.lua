local vim = vim

return {
  'inside/vim-search-pulse',
  enabled = true,

  init = function()
    vim.g.vim_search_pulse_disable_auto_mappings = 1
    vim.g.vim_search_pulse_duration = 200
    vim.g.vim_search_pulse_mode = 'pattern'
  end,

  config = function()
    vim.api.nvim_set_keymap('n', 'n', "v:searchforward ? 'n<Plug>Pulse' : 'N<Plug>Pulse'", {noremap = true, expr = true, silent = true})
    vim.api.nvim_set_keymap('n', 'N', "v:searchforward ? 'N<Plug>Pulse' : 'n<Plug>Pulse'", {noremap = true, expr = true, silent = true})
    vim.keymap.set('c', '<Enter>', 'search_pulse#PulseFirst()', { silent = true, expr = true, })
  end,
}
