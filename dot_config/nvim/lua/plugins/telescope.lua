local vim = vim

return {
  enabled = false,
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = { 'nvim-lua/plenary.nvim', },

  config = function()
    vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope find_files<cr>')
    vim.keymap.set('n', '<leader>s', '<cmd>Telescope live_grep<cr>')
    vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>')

    require('telescope').setup({
      pickers = {
        find_files = {
          hidden = true,
        },
      },

      defaults = {
        border = true,
        borderchars = {
          results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', },
          prompt = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', },
          preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', },
        },

        layout_strategy = 'vertical',
        layout_config = {
          preview_cutoff = 0,
          height = 999,
          width = 999,
        },

        mappings = {
          i = {
            ['<esc>'] = require('telescope.actions').close,
            ['<c-q>'] = require('telescope.actions').close,
          },
        },
      },
    })
  end,
}
