local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.o
local map = vim.keymap.set
local call = vim.call
local api = vim.api

-------------------- chaoren/vim-wordmotion
-- local function wordmotion()
--   g.wordmotion_nomap = 1
-- end

-------------------- cshuaimin/ssr.nvim
local function ssr()
  require('ssr').setup {
    min_width = 50,
    min_height = 5,
    keymaps = {
      close = 'q',
      next_match = 'n',
      prev_match = 'N',
      replace_all = '<C-CR>',
    },
  }
end

-------------------- is0n/fm-nvim
local function fm()
  require('fm-nvim').setup({
    edit_cmd = 'edit',
    ui = {
      default = 'float',
      float = {
        border = 'none',
        float_hl = 'Normal',
        border_hl = 'FloatBorder',
        blend = 0,
        height = 999,
        width = 999,
      },
      split = {
        direction = 'topleft',
        size = 24,
      },
    },
    cmds = {
      vifm_cmd = 'vifm',
    },
    mappings = {
      -- vert_split = "<C-v>",
      -- horz_split = "<C-h>",
      -- tabedit = "<C-t>",
      -- edit = "<C-e>",
      -- ESC = "<ESC>",
    },
  })
end

-------------------- jonatan-branting/nvim-better-n
local function bettern()
  require('better-n').setup {
    callbacks = {},
    mappings = {
      ['F'] = { previous = 'n', next = '<s-n>', },
      ['T'] = { previous = 'n', next = '<s-n>', },
    },
  }
end

return {
  fm = fm,
  bettern = bettern,
  ssr = ssr,
}
