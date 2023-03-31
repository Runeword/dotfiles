local cmd = vim.cmd
local lsp = vim.lsp
local fn = vim.fn
local diagnostic = vim.diagnostic

return function()
  -------------------- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
  diagnostic.config({
    virtual_text = {
      prefix = '',
      spacing = 2,
    },
    signs = false,
    float = {
      header = '',
      prefix = '',
      format = function(diagnostic)
        return string.format(
          ' %s %s %s',
          diagnostic.source,
          diagnostic.user_data.lsp.code,
          diagnostic.message
        )
      end,
    },
  })

  -------------------- neovim/nvim-lspconfig
  local function on_attach_server(documentFormattingProvider)
    return function(client, buffer)
      client.server_capabilities.documentFormattingProvider =
      documentFormattingProvider
      require('mappings').lspconfig(buffer)
    end
  end

  local lspconfig = require('lspconfig')
  local lsp_flags = { debounce_text_changes = 0, }

  lspconfig.tsserver.setup({
    on_attach = on_attach_server(false),
    autostart = true,
    -- cmd = {
    --   "typescript-language-server",
    --   "--stdio",
    --   "--tsserver-path",
    --   "/nix/store/34pzigggq36pk9sz9a95bz53qlqx1mpx-typescript-4.9.4/lib/node_modules/typescript/lib/"
    -- },
    ['settings.format.enable'] = false,
    flags = lsp_flags,
  })

  lspconfig['eslint'].setup({
    on_attach = on_attach_server(true),
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })

  lspconfig['lua_ls'].setup({
    on_attach = on_attach_server(true),
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })

  lspconfig['yamlls'].setup({
    on_attach = on_attach_server(true),
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })

  lspconfig['bashls'].setup({
    on_attach = on_attach_server(true),
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })

  lspconfig['ccls'].setup({
    on_attach = on_attach_server(true),
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })

  lspconfig['vuels'].setup({
    on_attach = on_attach_server(false),
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })

  lspconfig['nil_ls'].setup({
    on_attach = on_attach_server(true),
    settings = {
      ['nil'] = {
        formatting = {
          -- command = { 'nixpkgs-fmt' },
          command = { 'alejandra' },
        },
      },
    },
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })

  lspconfig['marksman'].setup({
    on_attach = on_attach_server(true),
    ['settings.format.enable'] = true,
    flags = lsp_flags,
  })
end

-- if server.name == "volar" then
--   opts.on_attach = on_attach_volar
--   opts.settings = { format = { enable = false } }
--   opts.init_options = {
--     documentFeatures = {
--       documentColor = false,
--       documentFormatting = {
--         defaultPrintWidth = 100
--       },
--       documentSymbol = true,
--       foldingRange = true,
--       linkedEditingRange = true,
--       selectionRange = true
--     },
--     languageFeatures = {
--       callHierarchy = true,
--       codeAction = false,
--       codeLens = true,
--       completion = {
--         defaultAttrNameCase = "kebabCase",
--         defaultTagNameCase = "both"
--       },
--       definition = true,
--       diagnostics = true,
--       documentHighlight = true,
--       documentLink = true,
--       hover = true,
--       implementation = true,
--       references = true,
--       rename = true,
--       renameFileRefactoring = true,
--       schemaRequestService = true,
--       semanticTokens = false,
--       signatureHelp = true,
--       typeDefinition = true
--     },
--     typescript = {
--       serverPath = ""
--     }
--   }
-- end
