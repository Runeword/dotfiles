local vim = vim

return {
  'tzachar/highlight-undo.nvim',

  init = function()
    vim.api.nvim_create_augroup('highlightundo', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'highlightundo',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'HighlightUndo', { bg = '#545454', fg = 'none', })
      end,
    })
  end,

  opts = {
    duration = 300,

    undo = {
      hlgroup = 'HighlightUndo',
      mode = 'n',
      lhs = 'u',
      map = 'undo',
      opts = {},
    },

    redo = {
      hlgroup = 'HighlightUndo',
      mode = 'n',
      lhs = '<C-r>',
      map = 'redo',
      opts = {},
    },

    highlight_for_count = true,
  },
}
