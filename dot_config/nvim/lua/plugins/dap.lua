local vim = vim

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'anuvyklack/hydra.nvim',
    'theHamsta/nvim-dap-virtual-text',
    -- 'rcarriga/nvim-dap-ui',
    -- 'jbyuki/one-small-step-for-vimkind',
  },

  init = function()
    vim.api.nvim_create_augroup('dap', { clear = true, })
    vim.api.nvim_create_autocmd('colorscheme', {
      group = 'dap',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'NvimDapVirtualText',        { bg = '#0a172e', fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'NvimDapVirtualTextChanged', { bg = '#222b66', fg = 'white', })
        vim.api.nvim_set_hl(0, 'DapBreakpoint',             { fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'DapLogPoint',               { fg = '#e4e8f2', })
        vim.api.nvim_set_hl(0, 'DapStopped',                { fg = '#c45661', })
      end,
    })
  end,

  config = function()
    require('nvim-dap-virtual-text').setup {
      enabled = true,                     -- enable this plugin (the default)
      enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true,            -- show stop reason when stopped for exceptions
      commented = false,                  -- prefix virtual text with comment string
      only_first_definition = false,      -- only show virtual text at first definition (if there are multiple)
      all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
      clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
      virt_text_pos = 'eol',
      display_callback = function(variable, buf, stackframe, node, options)
        return '󱄑  ' .. variable.name .. ' = ' .. variable.value
        -- return "x = " .. string.sub(variable.value, 1, 50)
      end,

      -- experimental features:
      all_frames = false,      -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false,      -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    }

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '', })
    vim.fn.sign_define('DapStopped',    { text = '', texthl = 'DapStopped', linehl = '', numhl = '', })
    vim.fn.sign_define('DapLogPoint',   { text = '󰍥', texthl = 'DapLogPoint', linehl = '', numhl = '', })

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
        { 'r',         require('dap').repl.toggle, },
        -- { 'r',       require('dap').restart, },
        { 'q',         nil,                              { exit = true, }, },
        { '<Esc>',     nil,                              { exit = true, }, },
      },
    })

    vim.keymap.set({ 'n', 'x', }, '<Leader>d', function() mappings:activate() end)

    require('dap').set_log_level('TRACE');

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
