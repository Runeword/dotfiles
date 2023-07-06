local vim = vim

return {
  'chrisgrieser/nvim-spider',

  lazy = true,

  config = function()
    vim.keymap.set({ 'n', 'o', 'x', }, 'w',
      "<cmd>lua require('spider').motion('w')<CR>",
      { desc = 'Spider-w', })

    vim.keymap.set({ 'n', 'o', 'x', }, 'e',
      "<cmd>lua require('spider').motion('e')<CR>",
      { desc = 'Spider-w', })

    vim.keymap.set({ 'n', 'o', 'x', }, 'b',
      "<cmd>lua require('spider').motion('b')<CR>",
      { desc = 'Spider-w', })

    vim.keymap.set({ 'n', 'o', 'x', }, 'ge',
      "<cmd>lua require('spider').motion('ge')<CR>",
      { desc = 'Spider-w', })
  end,
}
