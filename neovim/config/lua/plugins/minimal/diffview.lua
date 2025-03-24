local vim = vim

return {
  'sindrets/diffview.nvim',

  config = function()
    vim.keymap.set('n', '<Leader>go', '<cmd>DiffviewOpen<Cr>')
    vim.keymap.set('n', '<Leader>gc', '<cmd>DiffviewClose<Cr>')

    local actions = require('diffview.actions')

    require('diffview').setup({
      file_panel = {
        listing_style = 'tree',            -- One of 'list' or 'tree'
        tree_options = {                   -- Only applies when listing_style is 'tree'
          flatten_dirs = true,             -- Flatten dirs that only contain one single dir
          folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = {                     -- See |diffview-config-win_config|
          position = 'left',
          width = 25,
          win_opts = {},
        },
        keymaps = {
          disable_defaults = true,
          view = {},
        },
      },
    })
  end,
}
