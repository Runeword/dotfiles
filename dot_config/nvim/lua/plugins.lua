return {
  -- {
  --   'woosaaahh/sj.nvim',
  --   config = function()
  --     require('setup').sj()
  --     require('mappings').sj()
  --   end,
  -- },

  { 'nvim-lua/plenary.nvim', },
  { 'nvim-tree/nvim-web-devicons', },
  { 'kana/vim-arpeggio', },

  -- {
  --   'luukvbaal/statuscol.nvim',
  --   config = function()
  --     require("statuscol").setup()
  --   end,
  -- },

  -- { 'mattn/vim-gist',
  --   dependencies = { 'mattn/webapi-vim' },
  -- },


  -- {
  --   'gelguy/wilder.nvim',
  --   dependencies = { "romgrk/fzy-lua-native" },
  --   rocks = 'pcre2',
  --   config = function()
  --     require("setup").wilder()
  --   end,
  -- },

  -- {
  --   'ray-x/starry.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     require('setup').starry()
  --   end,
  -- },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('setup').treesitter()
    end,
    build = ':TSUpdate',
  },

  {
    'anuvyklack/hydra.nvim',
    dependencies = 'anuvyklack/keymap-layer.nvim',
    config = function()
      require('mappings').hydra()
    end,
  },

  {
    'smjonas/live-command.nvim',
    config = function()
      require('setup').livecommand()
    end,
  },

  {
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
    'is0n/fm-nvim',
    config = function()
      require('mappings').fm()
      require('setup').fm()
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('setup').gitsigns()
    end,
  },

  {
    'gbprod/stay-in-place.nvim',
    config = function()
      require('setup').stayinplace()
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('setup').colorizer()
    end,
  },

  {
    'weilbith/nvim-code-action-menu',
    config = function()
      require('mappings').codeactionmenu()
      require('setup').codeactionmenu()
    end,
    cmd = 'CodeActionMenu',
  },

  {
    'nacro90/numb.nvim',
    config = function()
      require('setup').numb()
    end,
  },

  {
    'echasnovski/mini.ai',
    version = false,
    config = function()
      require('setup').ai()
    end,
  },

  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('autocmd').indentscope()
      require('setup').indentscope()
    end,
  },

  {
    'echasnovski/mini.align',
    version = false,
    config = function()
      require('setup').align()
    end,
  },

  { 'nvim-treesitter/nvim-treesitter-textobjects', },
  { 'windwp/nvim-ts-autotag', },
  { 'itchyny/vim-cursorword', },
  { 'tommcdo/vim-exchange', },
  { 'jghauser/mkdir.nvim', },
  -- { 'Exafunction/codeium.vim', },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('setup').comment()
      require('mappings').comment()
    end,
  },

  -- { 'smjonas/inc-rename.nvim',
  --   config = function()
  --     require('inc_rename').setup()
  --   end,
  -- },

  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('mappings').splitjoin()
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('setup').autopairs()
    end,
  },

  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('setup').project()
    end,
  },

  {
    'kosayoda/nvim-lightbulb',
    config = function()
      require('setup').lightbulb()
      require('autocmd').lightbulb()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', },
    config = function()
      require('setup.lualine')()
      require('autocmd').lualine()
    end,
  },

  {
    'linrongbin16/lsp-progress.nvim',
    event = { 'VimEnter', },
    dependencies = { 'nvim-tree/nvim-web-devicons', },
    config = function()
      require('setup').lspprogress()
    end,
  },

  {
    'ibhagwan/fzf-lua',
    config = function()
      require('mappings').fzf()
      require('setup').fzf()
    end,
  },

  {
    'monaqa/dial.nvim',
    config = function()
      require('mappings').dial()
      require('setup').dial()
    end,
  },

  { 'svban/YankAssassin.vim', },

  {
    'machakann/vim-highlightedyank',
    config = function()
      require('setup').highlightedyank()
    end,
  },

  {
    'glts/vim-textobj-comment',
    dependencies = 'kana/vim-textobj-user',
  },

  {
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
    'kana/vim-textobj-line',
    dependencies = 'kana/vim-textobj-user',
  },

  {
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
    'kylechui/nvim-surround',
    config = function()
      require('setup').surround()
    end,
  },

  { 'tpope/vim-abolish', },

  {
    'Runeword/putter.nvim',
    -- "/home/charles/Documents/dev/plugins/putter.nvim",
    config = function()
      require('mappings').putter()
    end,
  },
}
