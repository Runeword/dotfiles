local vim = vim

return {
  'ibhagwan/fzf-lua',

  config = function()
    vim.keymap.set('n', '<Leader><Leader>', require('fzf-lua').files)
    vim.keymap.set('n', '<Leader><Space>', require('fzf-lua').live_grep_resume)
    vim.keymap.set('n', '<Leader>h', require('fzf-lua').help_tags)
    vim.keymap.set('n', '<Leader>k', require('fzf-lua').keymaps)
    vim.keymap.set('n', '<Leader>sl', require('fzf-lua').highlights)
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
