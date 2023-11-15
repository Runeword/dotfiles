local vim = vim

return {
  { 'nvim-lua/plenary.nvim', },
  { 'nvim-tree/nvim-web-devicons', },
  { 'kana/vim-arpeggio', },
  { 'tpope/vim-abolish', },
  { 'svban/YankAssassin.vim', },
  { 'Pocco81/auto-save.nvim', },

  {
    'willothy/flatten.nvim',
    config = true,
    lazy = false,
    priority = 1001,
  },

  {
    'gbprod/stay-in-place.nvim',
    config = function()
      local stayinplace = require('stay-in-place')
      stayinplace.setup({
        set_keymaps = false,
        preserve_visual_selection = true,
      })
      vim.keymap.set('n', '>', stayinplace.shift_right_line,   { noremap = true, })
      vim.keymap.set('n', '<', stayinplace.shift_left_line,    { noremap = true, })
      vim.keymap.set('n', '=', stayinplace.filter_line,        { noremap = true, })

      vim.keymap.set('x', '>',  stayinplace.shift_right_visual, { noremap = true, })
      vim.keymap.set('x', '<',  stayinplace.shift_left_visual,  { noremap = true, })
      vim.keymap.set('x', '=',  stayinplace.filter_visual,      { noremap = true, })
    end,
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
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup()
    end,
  },

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
