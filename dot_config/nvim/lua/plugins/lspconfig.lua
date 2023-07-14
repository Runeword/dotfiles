local vim = vim

return {
  'neovim/nvim-lspconfig',

  config = function()
    -------------------- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
    vim.diagnostic.config(
      {
        signs = false,
        -- whynothugo/lsp_lines.nvim
        -- virtual_lines = { only_current_line = true },

        virtual_text = {
          prefix = '',
          spacing = 2,
        },

        float = {
          header = '',
          prefix = '',
          format = function(diag)
            return string.format(
              '󱞩 %s %s %s',
              diag.source,
              diag.user_data.lsp.code,
              diag.message
            )
          end,
        },
      }
    )

    -------------------- neovim/nvim-lspconfig
    local function on_attach_server(dfp)
      return function(client, buffer)
        client.server_capabilities.documentFormattingProvider = dfp
        client.server_capabilities.semanticTokensProvider = nil

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buffer, })
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = buffer, })

        vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, { buffer = buffer, })
        vim.keymap.set('n', '<Leader>a', '<cmd>CodeActionMenu<Enter>',
          { buffer = buffer, })

        -- vim.keymap.set('n', '<leader>r', function() lsp.buf.rename(vim.fn.input('New Name: ')) end, { buffer = buffer })
        -- vim.keymap.set("n", '<ScrollWheelUp>', diagnostic.goto_prev, { buffer = buffer })
        -- vim.keymap.set("n", '<ScrollWheelDown>', diagnostic.goto_next, { buffer = buffer })

        vim.keymap.set('n', '<PageUp>', vim.diagnostic.goto_prev,
          { buffer = buffer, })
        vim.keymap.set('n', '<PageDown>', vim.diagnostic.goto_next,
          { buffer = buffer, })

        vim.keymap.set('n', '<Leader>x', vim.diagnostic.setqflist,
          { noremap = true, silent = true, })

        -- vim.keymap.set('n', '<Leader>l', diagnostic.setloclist, { noremap = true, silent = true })
        -- lsp.buf.formatting_seq_sync(nil, 6000, { 'tsserver', 'html', 'cssls', 'vuels', 'eslint' })
        -- lsp.buf.formatting_seq_sync
      end
    end

    local function set_config(override_opts)
      local default_opts = {
        on_attach = on_attach_server(true),
        ['settings.format.enable'] = true,
        flags = { debounce_text_changes = 0, },
      }
      return vim.tbl_deep_extend('force', default_opts, override_opts or {})
    end


    local lspconfig = require('lspconfig')

    lspconfig['eslint'].setup(set_config())
    lspconfig['lua_ls'].setup(set_config())
    lspconfig['yamlls'].setup(set_config())
    lspconfig['ccls'].setup(set_config())
    lspconfig['jsonls'].setup(set_config())
    lspconfig['marksman'].setup(set_config())
    lspconfig['bashls'].setup(set_config())
    lspconfig['cssls'].setup(set_config())
    lspconfig['vuels'].setup(set_config({ on_attach = on_attach_server(false), }))

    lspconfig.tsserver.setup(set_config(
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
              command = { 'alejandra', }, -- 'nixpkgs-fmt'
            },
          },
        },
      }
    ))
  end,
}
