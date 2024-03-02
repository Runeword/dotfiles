local vim = vim

return {
  'rolv-apneseth/tfm.nvim',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader><Esc>', '', {
      noremap = true,
      callback = require('tfm').open,
    })
  end,
  opts = {
    file_manager = 'yazi',
    replace_netrw = true,
    enable_cmds = true,
    keybindings = {
      ['<ESC>'] = 'q',
    },
    ui = {
      border = 'none',
      height = 1,
      width = 1,
      x = 0,
      y = 0,
    },
  },
}
