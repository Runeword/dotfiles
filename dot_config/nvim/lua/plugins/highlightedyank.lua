local vim = vim

return {
  'machakann/vim-highlightedyank',

  config = function()
    vim.g.highlightedyank_highlight_duration = 130
  end,
}
