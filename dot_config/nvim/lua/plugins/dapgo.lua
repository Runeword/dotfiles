local vim = vim

return {
  'leoluz/nvim-dap-go',
  enabled = true,

  dependencies = { 'mfussenegger/nvim-dap', },

  config = function()
    require('dap-go').setup()
  end,
}
