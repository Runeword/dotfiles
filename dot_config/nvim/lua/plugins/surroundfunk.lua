local vim = vim

return {
  'Matt-A-Bennett/vim-surround-funk',
  enabled = false,
  config = function()
    vim.g.surround_funk_create_mappings = 0

    vim.keymap.set({ 'x', 'o', }, 'an', '<Plug>(SelectFunctionName)', { silent = true, })
    vim.keymap.set({ 'x', 'o', }, 'aN', '<Plug>(SelectFunctionNAME)', { silent = true, })
    vim.keymap.set({ 'x', 'o', }, 'in', '<Plug>(SelectFunctionName)', { silent = true, })
    vim.keymap.set({ 'x', 'o', }, 'iN', '<Plug>(SelectFunctionNAME)', { silent = true, })
  end,
}
