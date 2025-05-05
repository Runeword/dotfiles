local vim = vim

return {
  'neovim/nvim-lspconfig',

  dependencies = { 'hrsh7th/nvim-cmp', },

  enabled = true,

  config = function()
    local function on_attach_server(dfp)
      return function(client, buffer)
        client.server_capabilities.documentFormattingProvider = dfp
        client.server_capabilities.semanticTokensProvider = nil

        vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', { buffer = buffer, })
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = buffer, })
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { buffer = buffer, })
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { buffer = buffer, })
        vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { buffer = buffer, })
        vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.references()<cr>', { buffer = buffer, })
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = buffer, })
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = buffer, })
        -- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { buffer = buffer, })
        -- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { buffer = buffer, })

        -- vim.keymap.set('n', 'gd', function()
        --   if not vim.lsp.buf.definition() then vim.lsp.buf.declaration() end
        -- end, { buffer = buffer, })

        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = buffer, })

        -- vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, { buffer = buffer, })

        -- vim.keymap.set('n', '<leader>r', function() lsp.buf.rename(vim.fn.input('New Name: ')) end, { buffer = buffer })
        -- vim.keymap.set("n", '<ScrollWheelUp>', diagnostic.goto_prev, { buffer = buffer })
        -- vim.keymap.set("n", '<ScrollWheelDown>', diagnostic.goto_next, { buffer = buffer })

        -- vim.keymap.set('n', '<PageUp>', function() return vim.diagnostic.goto_prev({ float = { max_width = 50, }, }) end,
        -- { buffer = buffer, })

        -- vim.keymap.set('n', '<PageUp>',   vim.diagnostic.goto_prev, { buffer = buffer, })
        -- vim.keymap.set('n', '<PageDown>', vim.diagnostic.goto_next, { buffer = buffer, })

        -- vim.keymap.set('n', '<Leader>x', vim.diagnostic.setqflist,
        -- { noremap = true, silent = true, })

        -- vim.keymap.set('n', '<Leader>l', diagnostic.setloclist, { noremap = true, silent = true })
        -- lsp.buf.formatting_seq_sync(nil, 6000, { 'ts_ls', 'html', 'cssls', 'vuels', 'eslint' })
        -- lsp.buf.formatting_seq_sync
      end
    end

    local cmp_exists, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

    local function set_config(override_opts)
      local default_opts = {
        capabilities = cmp_exists and cmp_nvim_lsp.default_capabilities() or {}, -- hrsh7th/nvim-cmp
        on_attach = on_attach_server(true),
        ['settings.format.enable'] = true,
        flags = { debounce_text_changes = 0, },
      }
      return vim.tbl_deep_extend('force', default_opts, override_opts or {})
    end

    local lspconfig = require('lspconfig')

    lspconfig['lua_ls'].setup(set_config())
    lspconfig.yamlls.setup(set_config())
    lspconfig.ccls.setup(set_config())
    lspconfig.eslint.setup(set_config())
    lspconfig.jsonls.setup(set_config())
    lspconfig.gopls.setup(set_config())
    lspconfig['rust_analyzer'].setup(set_config())
    lspconfig.marksman.setup(set_config())
    lspconfig.terraformls.setup(set_config())
    lspconfig.taplo.setup(set_config())
    lspconfig.bashls.setup(set_config({ filetypes = { 'sh', 'zsh', }, }))
    lspconfig.cssls.setup(set_config())
    lspconfig.volar.setup(set_config({ on_attach = on_attach_server(false), }))
    lspconfig.pyright.setup(set_config())
    -- lspconfig.harper_ls.setup(set_config({ filetypes = { 'markdown', }, }))

    lspconfig['ts_ls'].setup(set_config(
      {
        on_attach = on_attach_server(false),
        autostart = true,
        ['settings.format.enable'] = false,
      }
    ))

    lspconfig['nil_ls'].setup(set_config(
      {
        settings = {
          ['nil'] = {
            formatting = {
              -- command = { 'alejandra', },
              command = { 'nixfmt', },
            },
          },
        },
      }
    ))

    -------------------- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
    vim.diagnostic.config(
      {
        signs = false,

        update_in_insert = false,

        virtual_text = {
          prefix = '',
          spacing = 2,
        },

        float = {
          border = {
            { '',  'FloatBorder', },
            { '',  'FloatBorder', },
            { '',  'FloatBorder', },
            { ' ', 'FloatBorder', },
            { ' ', 'FloatBorder', },
            { ' ', 'FloatBorder', },
            { ' ', 'FloatBorder', },
            { ' ', 'FloatBorder', },
          },

          max_width = 80,
          header = '',
          prefix = '',
          suffix = '',

          format = function(diag)
            return string.format(
              '%s %s\n    %s',
              diag.source,
              diag.user_data.lsp.code,
              diag.message
            )
          end,
        },
      }
    )
  end,

  init = function()
    vim.api.nvim_create_augroup('diagnostic', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'diagnostic',
      pattern = '*',
      callback = function()
        -- #0a172e #10141f #1a1a3b #1e2633 #424a57 #7a7c9e #222b66

        vim.api.nvim_set_hl(0, 'DiagnosticError', { bg = 'NONE', fg = '#cf4e84', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'DiagnosticError', { bg = 'NONE', fg = '#cf4e84', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError',
          { bg = 'NONE', fg = '#cf4e84', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { bg = 'NONE', undercurl = true, sp = '#cf4e84', })
        vim.api.nvim_set_hl(0, 'diagnosticWarn', { bg = 'NONE', fg = '#ff9d57', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'diagnosticVirtualTextWarn', { bg = 'NONE', fg = '#ff9d57', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'diagnosticUnderlineWarn', { bg = 'NONE', undercurl = true, sp = '#ff9d57', })
        vim.api.nvim_set_hl(0, 'diagnosticInfo', { bg = 'NONE', fg = '#a6c8ff', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'diagnosticVirtualTextInfo', { bg = 'NONE', fg = '#a6c8ff', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'diagnosticUnderlineInfo', { bg = 'NONE', undercurl = true, sp = '#a6c8ff', })
        vim.api.nvim_set_hl(0, 'diagnosticHint', { bg = 'NONE', fg = '#adb5bd', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'diagnosticVirtualTextHint', { bg = 'NONE', fg = '#adb5bd', bold = false, italic = true, })
        vim.api.nvim_set_hl(0, 'diagnosticUnderlineHint', { bg = 'NONE', undercurl = true, sp = '#adb5bd', })
        vim.api.nvim_set_hl(0, 'diagnosticUnnecessary', { bg = 'NONE', undercurl = true, sp = '#adb5bd', })

        -- vim.api.nvim_set_hl(0, 'diagnosticfloatingerror',  { link = 'diagnosticvirtualtexterror', })
        -- vim.api.nvim_set_hl(0, 'diagnosticfloatinghint',   { link = 'diagnosticvirtualtexthint', })
        -- vim.api.nvim_set_hl(0, 'diagnosticfloatinginfo',   { link = 'diagnosticvirtualtextinfo', })
        -- vim.api.nvim_set_hl(0, 'diagnosticfloatingwarn',   { link = 'diagnosticvirtualtextwarn', })
      end,
    })
  end,
}
