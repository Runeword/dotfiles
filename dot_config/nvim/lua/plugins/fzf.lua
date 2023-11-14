local vim = vim

return {
  --   {
  --     'junegunn/fzf',
  --     config = function()
  --       vim.cmd [[
  --     autocmd! FileType fzf
  --     autocmd FileType fzf tnoremap <buffer> <esc> <c-c>
  --     autocmd  FileType fzf set laststatus=0 noshowmode noruler
  --       \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  --     ]]
  --
  --       vim.keymap.set('n', '<Tab>',
  --         function()
  --           vim.fn['fzf#run'] {
  --             sink = 'e',
  --             window = { width = 0.9, height = 0.6, },
  --             options = { '--preview=bat {}' }
  --           }
  --         end,
  --         { silent = true, })
  --     end,
  --   },
  -- }

  'ibhagwan/fzf-lua',
  enabled = true,

  config = function()
    vim.keymap.set('n', '<Tab>',     require('fzf-lua').files)
    vim.keymap.set('n', '<S-Tab>',   require('fzf-lua').live_grep_resume)
    vim.keymap.set('n', '<Leader>h', require('fzf-lua').help_tags)
    vim.keymap.set('n', '<Leader>k', require('fzf-lua').keymaps)
    vim.keymap.set('n', '<Leader>i', require('fzf-lua').highlights)
    -- vim.keymap.set("n", "<Leader>x", "<cmd>lua require('fzf-lua').quickfix({multiprocess=true})<CR>")

    local actions = require('fzf-lua.actions')

    require('fzf-lua').setup({
      winopts = {
        fullscreen = true,
        border = 'none',
        preview = {
          layout = 'horizontal',
          horizontal = 'up:70%',
          title = false,
          delay = 0,
          scrollchars = { '▎', '', },
        },
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
