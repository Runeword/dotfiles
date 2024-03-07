local vim = vim

return {
  'nvim-pack/nvim-spectre',

  dependencies = 'nvim-lua/plenary.nvim',

  config = function()
    require('spectre').setup({
      open_cmd = 'below vnew | set nonumber | set nolist',
      is_block_ui_break = true,
      is_insert_mode = true,
      live_update = true,

      highlight = {
        ui = 'Default',
        search = 'DiffChange',
        replace = 'DiffDelete',
      },

      mapping = {
        ['quit_q'] = {
          map = 'q',
          cmd = '<cmd>silent bwipeout!<CR>',
          desc = 'quit',
        },

        ['quit_Q'] = {
          map = 'Q',
          cmd = '<cmd>silent bwipeout!<CR>',
          desc = 'quit',
        },

        ['enter_file'] = {
          map = 'gx',
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = 'open file',
        },
      },
    })

    vim.keymap.set('n', '<leader>c', '<cmd>lua require("spectre").toggle()<CR>', {
      desc = 'Search',
    })

    vim.keymap.set('n', '<leader>*', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
      desc = 'Search current word',
    })

    vim.keymap.set('v', '<leader>c', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
      desc = 'Search visual selection',
    })
  end,
}
