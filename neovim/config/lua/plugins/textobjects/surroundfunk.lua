local vim = vim

return {
  'Matt-A-Bennett/vim-surround-funk',

  enabled = true,

  init = function()
    vim.g.surround_funk_create_mappings = 0
  end,

  config = function()
    vim.keymap.set({ 'x', 'o', }, 'n',  '<Plug>(SelectFunctionNAME)', { silent = true, })
    vim.keymap.set({ 'x', 'o', }, 'in', '<Plug>(SelectFunctionName)', { silent = true, })
    vim.keymap.set({ 'x', 'o', }, 'an', '<Plug>(SelectFunctionNAME)', { silent = true, })
  end,
}
