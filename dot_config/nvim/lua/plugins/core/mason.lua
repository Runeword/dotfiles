local vim = vim

return {
  enabled = false,

  'williamboman/mason.nvim',

  config = function()
    require('mason').setup({ ui = { border = 'single', }, })

    vim.keymap.set('n', '<Leader>m', '<cmd>Mason<Cr>')
  end,
}
