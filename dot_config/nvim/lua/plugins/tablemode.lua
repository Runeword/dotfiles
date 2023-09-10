local vim = vim

return {
  'dhruvasagar/vim-table-mode',

  enabled = false,

  init = function()
    vim.g.table_mode_disable_mappings = 1
    vim.g.table_mode_disable_tableize_mappings = 1
    vim.g.table_mode_syntax = 0
  end,

  config = function()
    vim.keymap.set('n', '<Leader>ta', '<Cmd>TableModeToggle<CR>')
  end,
}
