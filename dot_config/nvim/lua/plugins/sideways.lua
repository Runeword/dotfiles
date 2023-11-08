local vim = vim

return {
  'AndrewRadev/sideways.vim',
  enabled = true,

  config = function()
    vim.keymap.set('n', '<Left>', '<cmd>SidewaysJumpLeft<CR>')
    vim.keymap.set('n', '<Right>', '<cmd>SidewaysJumpRight<CR>')
    vim.keymap.set('n', '<S-Left>', '<cmd>SidewaysLeft<CR>')
    vim.keymap.set('n', '<S-Right>', '<cmd>SidewaysRight<CR>')
  end,
}
