local vim = vim

return {
  'lewis6991/gitsigns.nvim',

  enabled = true,

  config = function()
    require('gitsigns').setup({
      current_line_blame_opts = {
        delay = 0,
      },

      on_attach = function(buffer)
        vim.keymap.set({ 'n', 'x', }, '<leader>ga',
          package.loaded.gitsigns.stage_buffer,
          { buffer = buffer, desc = 'git add file', })
        vim.keymap.set({ 'n', 'x', }, '<leader>gr',
          package.loaded.gitsigns.reset_buffer_index,
          { buffer = buffer, desc = 'git reset file', })
        vim.keymap.set({ 'n', 'x', }, '<leader>gc',
          package.loaded.gitsigns.reset_buffer,
          { buffer = buffer, desc = 'git checkout -- file', })
        vim.keymap.set({ 'n', 'x', }, '<leader>gb',
          package.loaded.gitsigns.toggle_current_line_blame,
          { buffer = buffer, desc = 'git blame', })
        vim.keymap.set({ 'n', 'x', }, '<leader>gd',
          package.loaded.gitsigns.toggle_deleted,
          { buffer = buffer, })
      end,

      signs = {
        add = {
          -- hl = 'GitSignsAdd',
          text = '+',
          -- numhl = 'GitSignsAddNr',
          -- linehl = 'GitSignsAddLn',
        },
        change = {
          -- hl = 'GitSignsChange',
          text = '~',
          -- numhl = 'GitSignsChangeNr',
          -- linehl = 'GitSignsChangeLn',
        },
        delete = {
          -- hl = 'GitSignsDelete',
          text = '_',
          -- numhl = 'GitSignsDeleteNr',
          -- linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
          -- hl = 'GitSignsDelete',
          text = '‾',
          -- numhl = 'GitSignsDeleteNr',
          -- linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
          -- hl = 'GitSignsChange',
          text = '~',
          -- numhl = 'GitSignsChangeNr',
          -- linehl = 'GitSignsChangeLn',
        },
      },
    })
  end,
}
