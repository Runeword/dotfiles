local vim = vim

require('autocmd')
require('options')
require('mappings')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup(
  {
    { import = 'plugins', },
    { import = 'plugins.completion', },
    { import = 'plugins.core', },
    { import = 'plugins.debug', },
    { import = 'plugins.buffers', },
    { import = 'plugins.ui', },
    { import = 'plugins.search', },
    { import = 'plugins.textobjects', },
    { import = 'plugins.motions', },
    { import = 'plugins.operators', },
    { import = 'plugins.formatters', },
    { import = 'plugins.test', },
  },

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

    change_detection = {
      enabled = true,
      notify = false,
    },
  }
)

local viewConfig = require('lazy.view.config')

viewConfig.keys.details = 'o'
viewConfig.keys.close = '<Esc>'
viewConfig.keys.hover = 'K'
viewConfig.keys.diff = 'd'
viewConfig.keys.profile_sort = '<C-s>'
viewConfig.keys.profile_filter = '<C-f>'
viewConfig.keys.abort = '<C-c>'

viewConfig.commands.build.key_plugin = 'r'
