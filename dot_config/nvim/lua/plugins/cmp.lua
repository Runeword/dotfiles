local vim = vim

return {
  'hrsh7th/nvim-cmp',

  event = 'InsertEnter',

  pin = true,

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'jcdickinson/codeium.nvim',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },

  config = function()
    require('codeium').setup({})

    local cmp = require 'cmp'

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },

      window = {
        completion = {
        },
        documentation = {
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
        },
      },

      mapping = cmp.mapping.preset.insert({
        ['<S-Up>'] = cmp.mapping.scroll_docs(-4),
        ['<S-Down>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true, }),
      }),

      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            buffer = 'buff',
            nvim_lsp = 'lsp',
            luasnip = 'snip',
            codeium = 'codeium',
            nvim_lua = 'lua',
          })[entry.source.name]

          local MAX_LABEL_WIDTH = 50
          local MIN_LABEL_WIDTH = 10
          local ELLIPSIS_CHAR = ' '
          local label = vim_item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

          if truncated_label ~= label then
            vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
          elseif string.len(label) < MIN_LABEL_WIDTH then
            local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
            vim_item.abbr = label .. padding
          end

          return vim_item
        end,
      },

      sources = cmp.config.sources({
        { name = 'nvim_lsp', },
        { name = 'codeium', },
        { name = 'luasnip', },
      }, {
        { name = 'buffer', },
      }),
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git', }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = 'buffer', },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?', }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer', },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path', },
      }, {
        { name = 'cmdline', },
      }),
    })
  end,
}
