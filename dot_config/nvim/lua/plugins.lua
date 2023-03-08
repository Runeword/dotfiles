return {
  {
    enabled = true,
    'woosaaahh/sj.nvim',
    config = function()
      require('setup').sj()
      require('mappings').sj()
    end,
  },

  {
    enabled = true,
    'andymass/vim-matchup',
    init = function()
      require('options').matchup()
    end,
    config = function()
      require('mappings').matchup()
    end,
  },

  {
    enabled = true,
    'nvim-lua/plenary.nvim',
  },

  {
    enabled = true,
    'kyazdani42/nvim-web-devicons',
  },

  {
    enabled = true,
    'kana/vim-arpeggio',
  },

  {
    enabled = true,
    'dhruvasagar/vim-table-mode',
    init = function()
      require('setup').tablemode()
    end,
    config = function()
      require('mappings').tablemode()
    end,
  },

  {
    enabled = true,
    'mattn/vim-gist',
    dependencies = { 'mattn/webapi-vim' },
  },

  -- {
  --   'gelguy/wilder.nvim',
  --   dependencies = { "romgrk/fzy-lua-native" },
  --   -- rocks = 'pcre2',
  --   config = function()
  --     require("setup").wilder()
  --   end,
  -- },

  {
    enabled = true,
    'michaelb/sniprun',
    build = 'bash ./install.sh',
    config = function()
      require('setup').sniprun()
      require('mappings').sniprun()
    end,
  },

  {
    enabled = true,
    'rareitems/printer.nvim',
    config = function()
      require('setup').printer()
      require('mappings').printer()
    end,
  },

  {
    enabled = true,
    'mfussenegger/nvim-dap',
    config = function()
      require('mappings').dap()
      require('setup.dap')
    end,
  },

  {
    enabled = true,
    'akinsho/bufferline.nvim',
    config = function()
      require('mappings').bufferline()
      require('setup').bufferline()
    end,
  },

  {
    enabled = true,
    'inside/vim-search-pulse',
    config = function()
      require('mappings').pulse()
    end,
  },

  {
    enabled = true,
    'chrisgrieser/nvim-various-textobjs',
    config = function()
      require('setup').varioustextobjs()
      require('mappings').varioustextobjs()
    end,
  },

  {
    'ray-x/starry.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      require('setup').starry()
    end,
  },

  {
    enabled = true,
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('setup').treesitter()
    end,
    build = ':TSUpdate',
  },

  {
    enabled = true,
    'neovim/nvim-lspconfig',
    config = require('setup.lsp'),
  },

  {
    enabled = true,
    'anuvyklack/hydra.nvim',
    dependencies = 'anuvyklack/keymap-layer.nvim',
    config = function()
      require('mappings').hydra()
    end,
  },

  {
    enabled = true,
    'smjonas/live-command.nvim',
    config = function()
      require('setup').livecommand()
    end,
  },

  {
    enabled = true,
    'ms-jpq/coq_nvim',
    branch = 'coq',
    init = function()
      require('setup').coq()
    end,
    config = function()
      require('autocmd').coq()
      require('mappings').coq()
    end,
  },

  {
    enabled = true,
    'is0n/fm-nvim',
    config = function()
      require('mappings').fm()
      require('setup').fm()
    end,
  },

  {
    enabled = true,
    'lewis6991/gitsigns.nvim',
    config = function()
      require('setup').gitsigns()
    end,
  },

  {
    enabled = true,
    'gbprod/stay-in-place.nvim',
    config = function()
      require('setup').stayinplace()
    end,
  },

  {
    enabled = true,
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('setup').colorizer()
    end,
  },

  {
    enabled = true,
    'weilbith/nvim-code-action-menu',
    config = function()
      require('mappings').codeactionmenu()
      require('setup').codeactionmenu()
    end,
    cmd = 'CodeActionMenu',
  },

  {
    enabled = true,
    'nacro90/numb.nvim',
    config = function()
      require('setup').numb()
    end,
  },

  {
    enabled = true,
    'echasnovski/mini.nvim',
    config = function()
      require('autocmd').indentscope()
      require('setup').indentscope()
      require('setup').ai()
    end,
  },

  {
    enabled = true,
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  {
    enabled = true,
    'windwp/nvim-ts-autotag',
  },

  {
    enabled = true,
    'itchyny/vim-cursorword',
  },

  {
    enabled = true,
    'tommcdo/vim-exchange',
  },

  {
    enabled = true,
    'numToStr/Comment.nvim',
    config = function()
      require('setup').comment()
      require('mappings').comment()
    end,
  },

  {
    enabled = true,
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
    end,
  },

  {
    enabled = true,
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('mappings').splitjoin()
    end,
  },

  {
    enabled = true,
    'windwp/nvim-autopairs',
    config = function()
      require('setup').autopairs()
    end,
  },

  {
    enabled = true,
    'ahmedkhalf/project.nvim',
    config = function()
      require('setup').project()
    end,
  },

  {
    enabled = true,
    'kosayoda/nvim-lightbulb',
    config = function()
      require('setup').lightbulb()
      require('autocmd').lightbulb()
    end,
  },

  {
    enabled = true,
    'nvim-lualine/lualine.nvim',
    -- event = "VeryLazy",
    -- lazy = true,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = require('setup.lualine'),
  },

  {
    enabled = true,
    'ibhagwan/fzf-lua',
    config = function()
      require('mappings').fzf()
      require('setup').fzf()
    end,
  },

  {
    enabled = true,
    'monaqa/dial.nvim',
    config = function()
      require('mappings').dial()
      require('setup').dial()
    end,
  },

  {
    enabled = true,
    'svban/YankAssassin.vim',
  },

  {
    enabled = true,
    'machakann/vim-highlightedyank',
    config = function()
      require('setup').highlightedyank()
    end,
  },

  {
    enabled = true,
    'glts/vim-textobj-comment',
    dependencies = 'kana/vim-textobj-user',
  },

  {
    enabled = true,
    'D4KU/vim-textobj-chainmember',
    dependencies = 'kana/vim-textobj-user',
    init = function()
      require('setup').textobjchainmember()
    end,
    config = function()
      require('mappings').textobjchainmember()
    end,
  },

  {
    enabled = true,
    'kana/vim-textobj-line',
    dependencies = 'kana/vim-textobj-user',
  },

  {
    enabled = true,
    'AndrewRadev/sideways.vim',
    config = function()
      require('mappings').sideways()
    end,
  },

  -- {
  --   "chaoren/vim-wordmotion",
  --   init = function()
  --     require("setup").wordmotion()
  --   end,
  -- },

  {
    enabled = true,
    'kylechui/nvim-surround',
    config = function()
      require('setup').surround()
    end,
  },

  {
    enabled = true,
    'tpope/vim-abolish',
  },

  {
    enabled = true,
    'Runeword/putter.nvim',
    -- "/home/charles/Documents/dev/plugins/putter.nvim",
    config = function()
      require('mappings').putter()
    end,
  },
}
