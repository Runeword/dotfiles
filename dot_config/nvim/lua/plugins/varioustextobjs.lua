local vim = vim

return {
  'chrisgrieser/nvim-various-textobjs',

  config = function()
    require('various-textobjs').setup({ useDefaultKeymaps = false, })

    vim.keymap.set({ 'o', 'x', }, 'ak',
      function() require('various-textobjs').key(false) end)
    vim.keymap.set({ 'o', 'x', }, 'ik',
      function() require('various-textobjs').key(true) end)
    vim.keymap.set({ 'o', 'x', }, 'av',
      function() require('various-textobjs').value(false) end)
    vim.keymap.set({ 'o', 'x', }, 'iv',
      function() require('various-textobjs').value(true) end)
    -- vim.keymap.set({ 'o', 'x', }, 'ad',
    --   function() require('various-textobjs').number(false) end)
    -- vim.keymap.set({ 'o', 'x', }, 'id',
    --   function() require('various-textobjs').number(true) end)
  end,
}
