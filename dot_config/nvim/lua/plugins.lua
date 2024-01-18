local vim = vim

local plugins = {
  {
    'abeldekat/lazyflex.nvim',
    enabled = false,
    import = 'lazyflex.hook',

    -- opts = { enable_match = false, kw = { "nvim-treesitter" } },
    opts = {
      kw = {
        -- cmp
        'plenary.nvim',
        'nvim-cmp',
        'cmp-nvim-lsp',
        'cmp-buffer',
        'cmp-path',
        'cmp-cmdline',
        'codeium.nvim',
        'LuaSnip',
        'cmp_luasnip',
        -- cmp
        'plenary.nvim',
        'nvim-web-devicons',
        'im-arpeggio',
        'vim-abolish',
        'YankAssassin.vim',
        'flatten.nvim',
        'nvim-colorizer.lua',
        'numb.nvim',
        'nvim-treesitter-textobjects',
        'nvim-ts-autotag',
        'vim-exchange',
        'mkdir.nvim',
        'tree-setter',
        'project.nvim',
        'virt-column.nvim',
        -- 'vim-textobj-user',
        -- 'vim-textobj-comment',
        -- 'vim-textobj-line',
        -- 'vim-textobj-entire',
        -- 'vim-textobj-chainmember',
        'nvim-autopairs',
        'local-highlight.nvim',
        'splitjoin.nvim',
        'live-command.nvim',
        'mini.ai',
        'vim-surround-funk',
        'highlight-undo',
        'conform.nvim',
        'sideway.vim',
        'vim-highlightedyank',
        'mini.indentscope',
        'gitsigns.nvim',
        'vim-auto-save',
        'mini.align',
        'hydra.nvim',
        'lualine.nvim',
        'flash.nvim',
        'sniprun',
        'checker.nvim',
        'nvim-surround',
        'vim-asterisk',
        'nvim-treesitter',
        -- 'vim-matchup',
        'vim-search-pulse',
        'midnight.nvim',
        'codeium.nvim',
        'dial.nvim',
        'putter.nvim',
        'Comment.nvim',
        'nvim-code-action-menu',
        'bufferline.nvim',
        'nvim-spider',
        'appender.nvim',
        'printer.nvim',
        'nvim-various-textobjs',
        'stay-in-place.nvim',
        'nvim-lightbulb',
        'nvim-lspconfig',
      },
    },
  },

  { 'nvim-lua/plenary.nvim', },
  { 'nvim-tree/nvim-web-devicons', },
  { 'kana/vim-arpeggio', },
  { 'tpope/vim-abolish', },
  { 'svban/YankAssassin.vim', },

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

-- for key, value in pairs(plugins) do
--   plugins[key].enabled = false
-- end

return plugins
