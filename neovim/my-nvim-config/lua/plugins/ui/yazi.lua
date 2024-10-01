local vim = vim

return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader><ESC>',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
  },
  opts = {
    keymaps = {
    },
  },
}
