local vim = vim

return {
  'mfussenegger/nvim-dap',
  dependencies = { 'anuvyklack/hydra.nvim', },

  config = function()
    local mappings = require('hydra')({
      hint = '',

      mode = { 'o', 'n', 'x', },

      config = {
        -- hint = { type = 'cmdline' },
        hint = false,
        color = 'pink',
      },

      heads = {
        { 'c',     require('dap').continue, },
        { 'n',     require('dap').step_over, },
        { 'i',     require('dap').step_into, },
        { 'o',     require('dap').step_out, },
        { 'b',     require('dap').toggle_breakpoint, },
        { 'r',     require('dap').repl.open, },
        { 'q',     nil,                              { exit = true, }, },
        { '<Esc>', nil,                              { exit = true, }, },
        { '<C-s>', nil,                              { exit = true, }, },
      },
    })

    vim.keymap.set({ 'n', 'x', }, '<Leader>d', function() mappings:activate() end)

    require('dap').set_log_level('TRACE');

    require('dap').adapters.chrome = {
      type = 'executable',
      command = 'node',
      args = {
        vim.fn.stdpath 'data' ..
        '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js', },
    }

    require('dap').configurations.javascript = {
      {
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
    }

    require('dap').configurations.javascript = {
      {
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }

    require('dap').configurations.typescript = {
      {
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }

    require('dap').configurations.javascriptreact = {
      {
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }

    require('dap').configurations.typescriptreact = {
      {
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }
  end,
}
