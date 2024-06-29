local vim = vim

return {
  'ibhagwan/fzf-lua',
  enabled = true,

  config = function()
    vim.keymap.set('n', '<Leader><Tab>',        require('fzf-lua').files)
    vim.keymap.set('n', '<Leader><CR>', require('fzf-lua').live_grep_resume)
    vim.keymap.set('n', '<Leader>h',    require('fzf-lua').help_tags)
    vim.keymap.set('n', '<Leader>k',    require('fzf-lua').keymaps)
    vim.keymap.set('n', '<Leader>i',    require('fzf-lua').highlights)
    vim.keymap.set({ 'n', 'x', }, '<leader>a', function()
      require('fzf-lua').lsp_code_actions {
        winopts = {
          relative = 'cursor',
          width = 0.6,
          height = 0.6,
          row = 1,
          preview = { vertical = 'up:70%', },
        },
      }
    end)
    -- vim.keymap.set("n", "<Leader>x", "<cmd>lua require('fzf-lua').quickfix({multiprocess=true})<CR>")

    local actions = require('fzf-lua.actions')

    require('fzf-lua').setup({
      -- 'fzf-native',
      winopts = {
        fullscreen = false,
        border = 'single',
        preview = {
          layout = 'horizontal',
          horizontal = 'up:70%',
          title = false,
          delay = 0,
          scrollchars = { '▎', '', },
        },
      },

      fzf_opts = {
        ['--no-separator'] = true,
      },

      keymap = {
        builtin = {},
        fzf = {
          -- ["tab"] = "down",
          -- ["btab"] = "up",
          ['ctrl-e'] = 'preview-page-down',
          ['ctrl-u'] = 'preview-page-up',
        },
      },

      lsp = {
        code_actions = {
          previewer = 'codeaction_native',
          preview_pager =
          "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
        },
      },

      actions = {
        files = {
          ['default'] = actions.file_edit,
        },
        buffers = {
          ['default'] = actions.buf_edit,
        },
      },
    })
  end,
}
