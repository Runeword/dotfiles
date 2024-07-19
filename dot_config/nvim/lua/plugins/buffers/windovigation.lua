local vim = vim

return {
  'volskaya/windovigation.nvim',
  lazy = false,

  config = function()
    require('windovigation').setup()

    vim.keymap.set('n', '<C-S-CR>', function() require('windovigation.actions').move_to_previous_file() end,
      { silent = true, noremap = true, })
    vim.keymap.set('n', '<C-CR>', function() require('windovigation.actions').move_to_next_file() end,
      { silent = true, noremap = true, })
  end,
}
