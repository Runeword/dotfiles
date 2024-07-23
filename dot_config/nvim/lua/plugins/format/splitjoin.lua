local vim = vim

return {
  'AndrewRadev/splitjoin.vim',

  enabled = true,

  config = function()
    vim.g.splitjoin_split_mapping = ''
    vim.g.splitjoin_join_mapping = ''

    vim.keymap.set('n', 'gj', '<cmd>silent SplitjoinJoin<CR>')
    vim.keymap.set('n', 'gk', '<cmd>silent SplitjoinSplit<CR>')
  end,
}
