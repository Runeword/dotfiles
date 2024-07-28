local vim = vim

return {
  {
    'kana/vim-textobj-line',
    dependencies = 'kana/vim-textobj-user',
  },
  {
    'D4KU/vim-textobj-chainmember',
    dependencies = 'kana/vim-textobj-user',

    init = function()
      vim.g.textobj_chainmember_no_default_key_mappings = 1
    end,

    config = function()
      vim.keymap.set({ 'o', 'x', }, 'am', '<Plug>(textobj-chainmember-a)')
      vim.keymap.set({ 'o', 'x', }, 'im', '<Plug>(textobj-chainmember-i)')
      vim.keymap.set({ 'o', },      'm',  '<Plug>(textobj-chainmember-i)')
      -- vim.keymap.set({ 'o', 'x', }, 'aom', '<Plug>(textobj-chainmember-last-a)')
      -- vim.keymap.set({ 'o', 'x', }, 'iom', '<Plug>(textobj-chainmember-last-i)')
      -- vim.keymap.set({ 'o', 'x', }, 'anm', '<Plug>(textobj-chainmember-next-a)')
      -- vim.keymap.set({ 'o', 'x', }, 'inm', '<Plug>(textobj-chainmember-next-i)')
    end,
  },
  {
    'glts/vim-textobj-comment',
    dependencies = 'kana/vim-textobj-user',

    config = function()
      -- vim.keymap.set({ 'o', }, 'c', 'ac', { remap = true, })
      -- vim.keymap.set({ 'o', }, 'C', 'aC', { remap = true, })
    end,
  },
}
