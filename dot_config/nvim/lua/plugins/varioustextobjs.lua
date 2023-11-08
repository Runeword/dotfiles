local vim = vim

return {
  'chrisgrieser/nvim-various-textobjs',

  config = function()
    require('various-textobjs').setup({ useDefaultKeymaps = false, })

    vim.keymap.set({ 'o', }, 'd',
      function() require('various-textobjs').diagnostic() end)
    vim.keymap.set({ 'o', 'x', }, 'ak',
      function() require('various-textobjs').key('outer') end)
    vim.keymap.set({ 'o', 'x', }, 'ik',
      function() require('various-textobjs').key('inner') end)
    vim.keymap.set({ 'o', 'x', }, 'av',
      function() require('various-textobjs').value('outer') end)
    vim.keymap.set({ 'o', 'x', }, 'iv',
      function() require('various-textobjs').value('inner') end)
    vim.keymap.set({ 'o', 'x', }, 'iw',
      function() require('various-textobjs').subword('inner') end)
    -- vim.keymap.set({ 'o', 'x', }, 'aw',
    --   function() require('various-textobjs').subword(false) end)
    -- vim.keymap.set({ 'o', 'x', }, 'ad',
    --   function() require('various-textobjs').number(false) end)
    -- vim.keymap.set({ 'o', 'x', }, 'id',
    --   function() require('various-textobjs').number(true) end)
  end,
}
