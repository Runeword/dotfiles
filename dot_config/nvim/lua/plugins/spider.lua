local vim = vim

return {
  enabled = true,

  'chrisgrieser/nvim-spider',

  config = function()
    vim.keymap.set({ 'n', 'x', }, 'w',
      "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w', })
    vim.keymap.set({ 'n', 'x', }, 'b',
      "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b', })
    vim.keymap.set({ 'n', 'x', 'o', }, 'e',
      "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e', })
    vim.keymap.set({ 'n', 'x', 'o', }, 'ge',
      "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge', })

    vim.keymap.set({ 'o', }, 'w', 'iw')
    vim.keymap.set({ 'o', }, 'b', 'ib')

    -- vim.keymap.set({ 'n', }, 'e',  "<CMD>call search('\\>')<CR>",      { silent = true, noremap = true, })
    -- vim.keymap.set({ 'n', }, 'ge', "<CMD>call search('\\>', 'b')<CR>", { silent = true, noremap = true, })
  end,
}
