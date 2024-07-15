local vim = vim

return {
  'glts/vim-textobj-comment',

  dependencies = 'kana/vim-textobj-user',

  config = function()
    vim.keymap.set({ 'o', }, 'c', 'ac', { remap = true, })
    vim.keymap.set({ 'o', }, 'C', 'aC', { remap = true, })
  end,
}
