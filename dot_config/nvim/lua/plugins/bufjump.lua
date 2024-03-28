local vim = vim

return {
  'kwkarlwang/bufjump.nvim',

  config = function()
    require('bufjump').setup()
    vim.keymap.set('n', '<C-o>', function() require('bufjump').backward() end, { silent = true, noremap = true, })
    vim.keymap.set('n', '<C-i>', function() require('bufjump').forward() end,  { silent = true, noremap = true, })
  end,
}
