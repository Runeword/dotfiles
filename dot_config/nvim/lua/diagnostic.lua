local vim = vim

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
