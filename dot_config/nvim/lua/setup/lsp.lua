local cmd = vim.cmd
local lsp = vim.lsp
local fn = vim.fn
local diagnostic = vim.diagnostic
local tbl_deep_extend = vim.tbl_deep_extend

return function()
  -------------------- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization

  diagnostic.config(
    {
      signs = false,

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
      require('mappings').lspconfig(buffer)
    end
  end

  local function set_config(override_opts)
    local default_opts = {
      on_attach = on_attach_server(true),
      ['settings.format.enable'] = true,
      flags = { debounce_text_changes = 0, },
    }
    return tbl_deep_extend('force', default_opts, override_opts or {})
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
end
