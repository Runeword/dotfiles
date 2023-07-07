local vim = vim

return {
  'AndrewRadev/sideways.vim',

  config = function()
    vim.keymap.set('n', '<Left>', '<cmd>SidewaysJumpLeft<CR>')
    vim.keymap.set('n', '<Right>', '<cmd>SidewaysJumpRight<CR>')
    vim.keymap.set('n', '<C-Left>', '<cmd>SidewaysLeft<CR>')
    vim.keymap.set('n', '<C-Right>', '<cmd>SidewaysRight<CR>')
  end,
}
