local vim = vim

return {
  'mfussenegger/nvim-dap',
  enabled = false,

  dependencies = {
    -- 'anuvyklack/hydra.nvim',
    -- 'jbyuki/one-small-step-for-vimkind',
  },

  init = function()
    vim.api.nvim_create_augroup('dap', { clear = true, })
    vim.api.nvim_create_autocmd('colorscheme', {
      group = 'dap',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'DapBreakpoint',          { fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'DapLogPoint',            { fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'DapStopped',             { fg = '#c45661', })
      end,
    })
  end,

  config = function()
    vim.fn.sign_define('DapBreakpointCondition',
      {
        text = '󰇼',
        texthl = 'DapBreakpointCondition',
        linehl = '',
        numhl = '',
      })
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '', })
    vim.fn.sign_define('DapStopped',    { text = '󰓗', texthl = 'DapStopped', linehl = '', numhl = '', })
    vim.fn.sign_define('DapLogPoint',   { text = '󱂅', texthl = 'DapLogPoint', linehl = '', numhl = '', })


    local mappings = require('hydra')({
      mode = { 'o', 'n', 'x', },

      config = {
        hint = { type = 'window', },
        color = 'pink',
        foreign_keys = 'run',
        exit = false,
      },

      heads = {
        { 'n',       require('dap').continue, },
        { '<Enter>', require('dap').continue, },
        { 'x',       require('dap').close, },
        { 'X',       require('dap').terminate, },
        { 't', function()
          require('dap').run({
            type = 'go',
            name = 'Debug test (go.mod)',
            request = 'launch',
            mode = 'test',
            program = './${relativeFileDirname}',
          })
        end, },
        { 'v',         require('dap').step_over, },
        { 'i',         require('dap').step_into, },
        { 'o',         require('dap').step_out, },
        { 'b',         require('dap').toggle_breakpoint, },
        { '<C-Space>', require('dap').clear_breakpoints, },
        { 'c',         function() require('dap').toggle_breakpoint(vim.fn.input('Breakpoint condition: ')) end, },
        { 'l',         function() require('dap').toggle_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, },
        { 'r',         function() require('dap').repl.toggle({ height = 6, }) end, },
        { 'p',         require('dap.ui.widgets').preview, },
        { 't', function()
          require('dap').run({
            type = 'go',
            name = 'Debug test (go.mod)',
            request = 'launch',
            mode = 'test',
            program = './${relativeFileDirname}',
          })
        end, },
        { 'f', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.frames)
        end, },
        { 's', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end, },
        -- { 'r',       require('dap').restart, },
        { 'q',     nil, { exit = true, }, },
        { '<Esc>', nil, { exit = true, }, },
      },
    })

    vim.keymap.set({ 'n', 'x', }, '<Leader>d', function() mappings:activate() end)

    require('dap').set_log_level('TRACE');

    -- require('dap').adapters.bashdb = {
    --   type = 'executable',
    --   -- command = 'bash-debug-adapter',
    --   -- command = 'node',
    --   command = 'bashdb',
    --   name = 'bashdb',
    -- }

    -- local dap = require 'dap'
    -- dap.adapters.sh = {
    --   type = 'executable',
    --   -- command = 'bash-debug-adapter',
    --   name = 'bashdb',
    --   command = 'bashdb'
    --   -- command = '/home/charles/.nix-profile/bin/bashdb',
    -- }

    -- dap.configurations.sh = {
    --   {
    --     name = 'Launch Bash debugger',
    --     type = 'sh',
    --     request = 'launch',
    --     program = '${file}',
    --     cwd = '${fileDirname}',
    --     pathBashdb = '/nix/store/8yc9r06892bsrcdfw04707g1dqjyhwnv-bashdb-5.0-1.1.2/share/bashdb',
    --     pathBashdbLib = '/nix/store/8yc9r06892bsrcdfw04707g1dqjyhwnv-bashdb-5.0-1.1.2/share/bashdb/',
    --     pathBash = 'bash',
    --     pathCat = 'cat',
    --     pathMkfifo = 'mkfifo',
    --     pathPkill = 'pkill',
    --     env = {},
    --     args = {},
    --     -- showDebugOutput = true,
    --     -- trace = true,
    --   },
    -- }

    -- local dap = require('dap')

    --     dap.adapters.bashdb = {
    --       type = 'executable';
    --       command = 'bashdb';
    --       -- command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter';
    --       name = 'bashdb';
    --     }

    -- dap.configurations.sh = {
    --   {
    --     type = 'bashdb';
    --     request = 'launch';
    --     name = "Launch file";
    --     showDebugOutput = true;
    --     -- pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb';
    --     -- pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir';
    --     pathBashdb = "/nix/store/8yc9r06892bsrcdfw04707g1dqjyhwnv-bashdb-5.0-1.1.2/share/bashdb";
    --     pathBashdbLib = "/nix/store/8yc9r06892bsrcdfw04707g1dqjyhwnv-bashdb-5.0-1.1.2/share/bashdb/lib";
    --     trace = true;
    --     file = "${file}";
    --     program = "${file}";
    --     cwd = '${workspaceFolder}';
    --     pathCat = "cat";
    --     pathBash = "/bin/bash";
    --     pathMkfifo = "mkfifo";
    --     pathPkill = "pkill";
    --     args = {};
    --     env = {};
    --     terminalKind = "integrated";
    --   }
    -- }

    -- dap.configurations.sh = {
    --   {
    --     name = 'Launch Bash debugger',
    --     type = 'sh',
    --     request = 'launch',
    --     program = '${file}',
    --     cwd = '${fileDirname}',
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
