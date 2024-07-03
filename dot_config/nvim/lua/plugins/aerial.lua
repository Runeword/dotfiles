local vim = vim

return {
  'stevearc/aerial.nvim',

  enabled = false,

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('aerial').setup({
      open_automatic = false,

      backends = { 'treesitter', },

      icons = {
        Boolean = '',
      },

      lazy_load = false,

      on_attach = function(bufnr)
        vim.keymap.set('n', '<Down>',  '<cmd>AerialNext<CR>', { buffer = bufnr, })
        vim.keymap.set('n', '<Up>',    '<cmd>AerialPrev<CR>', { buffer = bufnr, })
        vim.keymap.set('n', '<Tab>',   '<cmd>AerialNext<CR>', { buffer = bufnr, })
        vim.keymap.set('n', '<S-Tab>', '<cmd>AerialPrev<CR>', { buffer = bufnr, })
        vim.keymap.set('n', '<Leader>u', '<cmd>AerialToggle!<CR>', { buffer = bufnr, })
      end,

      layout = {
        max_width = { 40, 0.2, },
        width = nil,
        min_width = 10,
        win_opts = {},
        default_direction = 'prefer_right',
        placement = 'window',
        resize_to_content = true,
        preserve_equality = false,
      },

      highlight_on_jump = false,

      filter_kind = false,
      show_guides = true,
    })
  end,
}
