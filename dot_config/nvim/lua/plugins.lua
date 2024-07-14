local vim = vim

local plugins = {
  { 'nvim-lua/plenary.nvim', },
  { 'nvim-tree/nvim-web-devicons', },
  { 'tpope/vim-abolish', },
  { 'svban/YankAssassin.vim', },

  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  },

  { 'windwp/nvim-ts-autotag', },
  { 'tommcdo/vim-exchange', },

  { 'jghauser/mkdir.nvim', },

  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup()
    end,
  },

  {
    'willothy/flatten.nvim',
    enabled = true,
    config = true,
    lazy = false,
    priority = 1001,
  },

  {
    'kana/vim-textobj-line',
    dependencies = 'kana/vim-textobj-user',
  },

  -- { 'HiPhish/rainbow-delimiters.nvim', },
  -- { 'mbbill/undotree', },
  -- { 'kana/vim-arpeggio', },

  -- {
  --   'paulhybryant/vim-textobj-path',
  --   dependencies = 'kana/vim-textobj-user',
  -- },

  -- { 'smjonas/inc-rename.nvim',
  --   config = function()
  --     require('inc_rename').setup()
  --   end,
  -- },

  -- { 'mattn/vim-gist',
  --   dependencies = { 'mattn/webapi-vim' },
  -- },
}

-- for key, value in pairs(plugins) do
--   plugins[key].enabled = false
-- end

return plugins
