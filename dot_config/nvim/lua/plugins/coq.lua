local vim = vim

return {
  'ms-jpq/coq_nvim',

  enabled = false,

  branch = 'coq',

  init = function()
    vim.g.coq_settings = {
      auto_start = 'shut-up',

      weights = {
        prefix_matches = 3,
        proximity = 0,
        recency = 0,
      },

      completion = {
        always = true,
        replace_prefix_threshold = 3,
        replace_suffix_threshold = 2,
        smart = true,
        skip_after = { '{', '}', '[', ']', ' ', },
      },

      match = {
        fuzzy_cutoff = 0.6,
        exact_matches = 2,
      },

      display = {
        preview = {
          positions = { east = 1, north = 2, south = 3, west = 4, },
          x_max_len = 100,
          border = 'single',
        },
        icons = { mode = 'none', },
        pum = {
          kind_context = { '   ', '', },
          source_context = { '', '', },
          fast_close = true,
        },
        ghost_text = { enabled = false, },
      },

      keymap = {
        recommended = false,
        pre_select = true,
        manual_complete = '',
        ['repeat'] = '',
        bigger_preview = '',
        jump_to_mark = '<c-Enter>',
        eval_snips = '',
        manual_complete_insertion_only = false,
      },

      clients = {
        snippets = {
          weight_adjust = 2,
          short_name = 'snip',
        },
        tree_sitter = {
          short_name = 'tree',
        },
        lsp = {
          short_name = 'lsp',
        },
        paths = {
          short_name = 'path',
        },
        tmux = {
          short_name = 'tmux',
        },
        buffers = {
          short_name = 'buff',
        },
      },
    }
  end,

  config = function()
    vim.api.nvim_create_augroup('coq', { clear = true, })
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = 'coq',
      pattern = '*/.config/nvim/coq-user-snippets/*.snip',
      command = 'silent! COQsnips compile',
    })

    vim.keymap.set('i', '<Esc>',
      function() return vim.fn.pumvisible() == 1 and '<C-e><Esc>`^' or '<Esc>`^' end,
      { expr = true, })
    vim.keymap.set('i', '<C-c>',
      function() return vim.fn.pumvisible() == 1 and '<C-e><C-c>' or '<C-c>' end,
      { expr = true, })
    vim.keymap.set('i', '<Tab>',
      function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end,
      { expr = true, })
    vim.keymap.set('i', '<S-Tab>',
      function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<BS>' end,
      { expr = true, })
    vim.keymap.set('n', '<Leader>cs', function() require('coq').Snips('edit') end)
  end,
}
