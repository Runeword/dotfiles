local vim = vim

return {
  'leoluz/nvim-dap-go',

  dependencies = { 'mfussenegger/nvim-dap', },

  config = function()
    require('dap-go').setup()

    require('dap').configurations.go = {
      {
        type = 'go',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
      },
    }
  end,
}
