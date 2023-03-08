local fn = vim.fn
local loop = vim.loop
local opt = vim.opt

require('autocmd').core()
require('options').core()
require('mappings').core()

local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
if not loop.fs_stat(lazypath) then
  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end

opt.runtimepath:prepend(lazypath)

require('lazy').setup(
  require('plugins'),
  {
    defaults = { lazy = false, },
    -- install = { colorscheme = { 'tokyonight', 'habamax' } },
    -- checker = { enabled = true },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  }
)

local viewConfig = require('lazy.view.config')

viewConfig.keys.details = 'o'
viewConfig.commands.build.key_plugin = 'r'
