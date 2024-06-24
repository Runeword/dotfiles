local vim = vim

return {
  'stevearc/aerial.nvim',
  opts = {},
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup({
      open_automatic = true,
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '<Up>',   '<cmd>AerialPrev<CR>', { buffer = bufnr, })
        vim.keymap.set('n', '<Down>', '<cmd>AerialNext<CR>', { buffer = bufnr, })
      end,
      layout = {
        default_direction = 'prefer_left',
      },
    })
  end,
}
