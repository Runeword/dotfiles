return {
  enabled = false,

  'williamboman/mason-lspconfig.nvim',

  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'tsserver',
        'eslint',
        'sumneko_lua',
        'yamlls',
        'vuels',
        'bashls',
        -- 'volar',
      },
      automatic_installation = false,
    })
  end,
}
