local vim = vim

return {
  'machakann/vim-highlightedyank',

  init = function()
    vim.api.nvim_create_augroup('highlightedyank', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'highlightedyank',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { link = 'Search', default = true, })
        -- vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { bg = '#222b66', })
        -- vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { bg = '#00ffa2', fg = 'black', })
        -- vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { bg = '#ff1994', fg = 'black', })
      end,
    })
  end,

  config = function()
    vim.g.highlightedyank_highlight_duration = 150
  end,
}
