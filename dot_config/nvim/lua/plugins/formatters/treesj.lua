local vim = vim

return {
  'Wansmer/treesj',

  enabled = false,

  dependencies = { 'nvim-treesitter/nvim-treesitter', },

  config = function()
    require('treesj').setup({
      max_join_length = 120,
      use_default_keymaps = false,
    })

    vim.keymap.set('n', 'g<CR>', require('treesj').toggle)
  end,
}
