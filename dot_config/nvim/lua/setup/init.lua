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

-------------------- williamboman/mason.nvim
local function mason()
  require('mason').setup({ ui = { border = 'single', }, })
end

-------------------- williamboman/mason-lspconfig.nvim
local function masonlspconfig()
  require('mason-lspconfig').setup({
    ensure_installed = {
      -- 'tsserver',
      -- 'eslint',
      -- 'sumneko_lua',
      -- 'yamlls',
      -- 'vuels',
      -- 'bashls',
      -- -- 'volar',
    },
    automatic_installation = false,
  })
end

return {
  fm = fm,
  bettern = bettern,
  mason = mason,
  masonlspconfig = masonlspconfig,
  ssr = ssr,
}
