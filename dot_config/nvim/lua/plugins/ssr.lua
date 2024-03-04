local vim = vim

return {
  enabled = false,
  'cshuaimin/ssr.nvim',

  config = function()
    vim.keymap.set({ 'n', 'x', }, '<Leader>c',
      function() require('ssr').open() end)

    require('ssr').setup {
      border = 'rounded',
      min_width = 50,
      min_height = 5,
      max_width = 120,
      max_height = 25,
      keymaps = {
        close = 'q',
        next_match = 'n',
        prev_match = 'N',
        replace_confirm = '<cr>',
        replace_all = '<C-CR>',
      },
    }
  end,
}
