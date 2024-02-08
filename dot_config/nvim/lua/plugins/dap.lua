local vim = vim

return {
  'mfussenegger/nvim-dap',

  dependencies = {
    'anuvyklack/hydra.nvim',
    -- 'rcarriga/nvim-dap-ui',
    -- 'jbyuki/one-small-step-for-vimkind',
  },

  init = function()
    vim.api.nvim_create_augroup('dap', { clear = true, })
    vim.api.nvim_create_autocmd('colorscheme', {
      group = 'dap',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'DapLogPoint',   { fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'DapStopped',    { fg = '#c45661', })
      end,
    })
  end,

  config = function()
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '', })
    vim.fn.sign_define('DapStopped',    { text = '', texthl = 'DapStopped', linehl = '', numhl = '', })
    vim.fn.sign_define('DapLogPoint',   { text = '󰍥', texthl = 'DapLogPoint', linehl = '', numhl = '', })


    local mappings = require('hydra')({
      mode = { 'o', 'n', 'x', },

      config = {
        hint = { type = 'window', },
        color = 'pink',
        foreign_keys = 'run',
        exit = false,
      },

      heads = {
        { 'n',         require('dap').continue, },
        { '<Enter>',   require('dap').continue, },
        { 'c',         require('dap').close, },
        { 't',         require('dap').terminate, },
        { 'o',         require('dap').step_over, },
        { 'i',         require('dap').step_into, },
        { 'u',         require('dap').step_out, },
        { '<Space>',   require('dap').toggle_breakpoint, },
        { '<C-Space>', require('dap').clear_breakpoints, },
        -- { 'r',         require('dap').repl.toggle, },
        -- { 'r',       require('dap').restart, },
        { 'q',         nil,                              { exit = true, }, },
        { '<Esc>',     nil,                              { exit = true, }, },
      },
    })

    vim.keymap.set({ 'n', 'x', }, '<Leader>d', function() mappings:activate() end)

    require('dap').set_log_level('TRACE');

    -- -- nvim lua

    -- require('dap').configurations.lua = {
    --   {
    --     type = 'nlua',
    --     request = 'attach',
    --     name = 'Attach to running Neovim instance',
    --   },
    -- }

    -- require('dap').adapters.nlua = function(callback, config)
    --   callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086, })
    -- end

    -- -- go

    -- require('dap').adapters.delve = {
    --   type = 'server',
    --   port = '${port}',
    --   executable = {
    --     command = 'dlv',
    --     args = { 'dap', '-l', '127.0.0.1:${port}', },
    --   },
    -- }

    -- -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    -- require('dap').configurations.go = {
    --   {
    --     type = 'delve',
    --     name = 'Debug',
    --     request = 'launch',
    --     program = '${file}',
    --   },
    --   {
    --     type = 'delve',
    --     name = 'Debug test', -- configuration for debugging test files
    --     request = 'launch',
    --     mode = 'test',
    --     program = '${file}',
    --   },
    --   -- works with go.mod packages and sub packages
    --   {
    --     type = 'delve',
    --     name = 'Debug test (go.mod)',
    --     request = 'launch',
    --     mode = 'test',
    --     program = './${relativeFileDirname}',
    --   },
    -- }

    -- js

    -- require('dap').adapters.chrome = {
    --   type = 'executable',
    --   command = 'node',
    --   args = {
    --     vim.fn.stdpath 'data' ..
    --     '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js', },
    -- }

    -- require('dap').configurations.javascript = {
    --   {
    --     type = 'node2',
    --     request = 'launch',
    --     program = '${file}',
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     console = 'integratedTerminal',
    --   },
    -- }

    -- require('dap').configurations.javascript = {
    --   {
    --     type = 'chrome',
    --     request = 'attach',
    --     program = '${file}',
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     port = 9222,
    --     webRoot = '${workspaceFolder}',
    --   },
    -- }

    -- require('dap').configurations.typescript = {
    --   {
    --     type = 'chrome',
    --     request = 'attach',
    --     program = '${file}',
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     port = 9222,
    --     webRoot = '${workspaceFolder}',
    --   },
    -- }

    -- require('dap').configurations.javascriptreact = {
    --   {
    --     type = 'chrome',
    --     request = 'attach',
    --     program = '${file}',
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     port = 9222,
    --     webRoot = '${workspaceFolder}',
    --   },
    -- }

    -- require('dap').configurations.typescriptreact = {
    --   {
    --     type = 'chrome',
    --     request = 'attach',
    --     program = '${file}',
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     port = 9222,
    --     webRoot = '${workspaceFolder}',
    --   },
    -- }
  end,
}
