local vim = vim

return {
  'ckolkey/ts-node-action',

  enabled = false,

  dependencies = { 'nvim-treesitter', },

  config = function()
    vim.keymap.set({ 'n', }, 'g<Tab>', require('ts-node-action').node_action, { desc = 'Trigger Node Action', })
  end,

  opts = {},
}
