local vim = vim

return {
  'monkoose/neocodeium',
  event = 'VeryLazy',
  enabled = true,

  config = function()
    local neocodeium = require('neocodeium')
    neocodeium.setup({
      silent = true,
    })

    vim.keymap.set('i', '<C-CR>', neocodeium.accept)
    vim.keymap.set('i', '<C-w>', neocodeium.accept_word)
    vim.keymap.set('i', '<C-e>', neocodeium.accept_line)
  end,
}
