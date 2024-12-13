local vim = vim

return {
  'hrsh7th/nvim-cmp',

  enabled = true,

  event = 'InsertEnter',
  -- pin = true,

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },

  init = function()
    -- hrsh7th/nvim-cmp
    vim.api.nvim_create_augroup('cmp', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'cmp',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'PmenuSel',                 { fg = 'NONE', bg = '#323f5c', })
        vim.api.nvim_set_hl(0, 'Pmenu',                    { fg = '#e4e8f2', bg = '#1e273b', })

        vim.api.nvim_set_hl(0, 'CmpItemKind',              { fg = '#e4e8f2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemAbbr',              { fg = '#e4e8f2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated',    { fg = '#00ffa2', bg = 'NONE', strikethrough = true, })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch',         { fg = '#00ffa2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy',    { fg = '#00ffa2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemMenu',              { fg = '#e4e8f2', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindField',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindProperty',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindEvent',         { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindText',          { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindEnum',          { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindKeyword',       { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindConstant',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindConstructor',   { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindReference',     { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindFunction',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindStruct',        { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindClass',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindModule',        { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindOperator',      { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindVariable',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindFile',          { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindUnit',          { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindSnippet',       { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindFolder',        { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindMethod',        { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindValue',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember',    { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindInterface',     { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindColor',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = 'NONE', bg = 'NONE', })
      end,
    })
  end,

  config = function()
    local cmp = require 'cmp'

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = {
        },
        documentation = {
          winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
        },
      },

      mapping = {
      -- ['<C-Space>'] = cmp.mapping.complete(),
      -- ['<C-e>'] = cmp.mapping.abort(),
        ['<S-Up>'] = cmp.mapping.scroll_docs(-4),
        ['<S-Down>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true, }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's', }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's', }),
      },

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
        {
          name = 'luasnip',
          -- prevent nvim-cmp from triggering snippets when the cursor is inside a string
          entry_filter = function()
            local context = require('cmp.config.context')
            return not context.in_treesitter_capture('string') and not context.in_syntax_group('String')
          end,
        },
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

    vim.keymap.set({ 'i', 's', }, '<C-Tab>',   function() luasnip.jump(1) end,  { silent = true, })
    vim.keymap.set({ 'i', 's', }, '<C-S-Tab>', function() luasnip.jump(-1) end, { silent = true, })

    require('luasnip.loaders.from_vscode').lazy_load({ paths = '~/.config/nvim/snippets', })
  end,
}
