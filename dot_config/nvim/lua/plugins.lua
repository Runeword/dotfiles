local vim = vim

return {
  { 'nvim-lua/plenary.nvim', },
  { 'nvim-tree/nvim-web-devicons', },
  { 'kana/vim-arpeggio', },
  { 'tpope/vim-abolish', },
  { 'svban/YankAssassin.vim', },
  { 'okuuva/auto-save.nvim', enabled = false },

  {
    'willothy/flatten.nvim',
    config = true,
    lazy = false,
    priority = 1001,
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  },

  -- { 'mbbill/undotree', },
  { 'nvim-treesitter/nvim-treesitter-textobjects', },
  { 'windwp/nvim-ts-autotag', },
  { 'tommcdo/vim-exchange', },
  { 'jghauser/mkdir.nvim', },
  { 'filNaj/tree-setter', },

  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup()
    end,
  },

  {
    'lukas-reineke/virt-column.nvim',
    enabled = false,
    config = function()
      require('virt-column').setup({ char = '▏', })
      vim.o.colorcolumn = '80'
    end,
  },

  {
    'glts/vim-textobj-comment',
    dependencies = 'kana/vim-textobj-user',
  },

  {
    'kana/vim-textobj-line',
    dependencies = 'kana/vim-textobj-user',
  },

  {
    'kana/vim-textobj-entire',
    dependencies = 'kana/vim-textobj-user',
  },

  -- { 'smjonas/inc-rename.nvim',
  --   config = function()
  --     require('inc_rename').setup()
  --   end,
  -- },

  -- { 'mattn/vim-gist',
  --   dependencies = { 'mattn/webapi-vim' },
  -- },
}
