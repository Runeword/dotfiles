local fn = vim.fn
local loop = vim.loop
local opt = vim.opt

require("autocmd").core()
require("options").core()
require("mappings").core()

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  {
    "woosaaahh/sj.nvim",
    config = function()
      require("setup").sj()
      require("mappings").sj()
    end,
  },
  {
    'andymass/vim-matchup',
    init = function()
      require("options").matchup()
    end,
    config = function()
      require("mappings").matchup()
    end,
  },
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "kana/vim-arpeggio",
  {
    'dhruvasagar/vim-table-mode',
    init = function()
      require("setup").tablemode()
    end,
    config = function()
      require("mappings").tablemode()
    end
  },
  {
    'mattn/vim-gist',
    dependencies = { "mattn/webapi-vim" },
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
    'michaelb/sniprun',
    build = 'bash ./install.sh',
    config = function()
      require("setup").sniprun()
      require("mappings").sniprun()
    end
  },
  {
    'rareitems/printer.nvim',
    config = function()
      require("setup").printer()
      require("mappings").printer()
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require('mappings').dap()
      require('setup.dap')
    end
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('mappings').bufferline()
      require('setup').bufferline()
    end
  },
  {
    "inside/vim-search-pulse",
    config = function()
      require("mappings").pulse()
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("setup").varioustextobjs()
      require("mappings").varioustextobjs()
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      -- autocommand will have no effect on previously sourced colorschemes so it must be added before any colorscheme is sourced
      require('autocmd').bufferline()
      require('autocmd').sj()
      require('autocmd').matchup()
    end,
    config = function()
      require('setup').tokyonight()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("setup").treesitter()
    end,
    build = ":TSUpdate",
  },
  {
    "neovim/nvim-lspconfig",
    config = require("setup.lsp")
  },
  -- {
  --   "williamboman/mason.nvim",
  --   config = function()
  --     require('setup').mason()
  --     require('mappings').mason()
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   config = function()
  --     require("setup").masonlspconfig()
  --   end
  -- },
  {
    'anuvyklack/hydra.nvim',
    dependencies = 'anuvyklack/keymap-layer.nvim',
    config = function()
      require("mappings").hydra()
    end,
  },
  {
    "smjonas/live-command.nvim",
    config = function()
      require("setup").livecommand()
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
    "is0n/fm-nvim",
    config = function()
      require("mappings").fm()
      require("setup").fm()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("setup").gitsigns()
    end,
  },
  {
    "gbprod/stay-in-place.nvim",
    config = function()
      require("setup").stayinplace()
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("setup").colorizer()
    end,
  },
  {
    'weilbith/nvim-code-action-menu',
    config = function()
      require("mappings").codeactionmenu()
      require("setup").codeactionmenu()
    end,
    cmd = 'CodeActionMenu',
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("setup").numb()
    end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require("autocmd").indentscope()
      require("setup").indentscope()
      require("setup").ai()
    end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "windwp/nvim-ts-autotag",
  "itchyny/vim-cursorword",
  "tommcdo/vim-exchange",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("setup").comment()
      require("mappings").comment()
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "AndrewRadev/splitjoin.vim",
    config = function()
      require("mappings").splitjoin()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("setup").autopairs()
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("setup").project()
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require('setup').lightbulb()
      require('autocmd').lightbulb()
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    -- event = "VeryLazy",
    -- lazy = true,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = require('setup.lualine')
  },
  {
    "ibhagwan/fzf-lua",
    config = function()
      require("mappings").fzf()
      require("setup").fzf()
    end,
  },
  {
    "monaqa/dial.nvim",
    config = function()
      require("mappings").dial()
      require("setup").dial()
    end,
  },
  "svban/YankAssassin.vim",
  {
    "machakann/vim-highlightedyank",
    config = function()
      require("setup").highlightedyank()
    end,
  },
  {
    "glts/vim-textobj-comment",
    dependencies = "kana/vim-textobj-user",
  },
  {
    "D4KU/vim-textobj-chainmember",
    dependencies = "kana/vim-textobj-user",
    init = function()
      require("setup").textobjchainmember()
    end,
    config = function()
      require("mappings").textobjchainmember()
    end,
  },
  {
    "kana/vim-textobj-line",
    dependencies = "kana/vim-textobj-user",
  },
  {
    "AndrewRadev/sideways.vim",
    config = function()
      require("mappings").sideways()
    end,
  },
  -- {
  --   "chaoren/vim-wordmotion",
  --   init = function()
  --     require("setup").wordmotion()
  --   end,
  -- },
  {
    "kylechui/nvim-surround",
    config = function()
      require("setup").surround()
    end
  },
  "tpope/vim-abolish",
  {
    "Runeword/putter.nvim",
    -- "/home/charles/Documents/dev/plugins/putter.nvim",
    config = function()
      require("mappings").putter()
    end,
  }
},
  {
    defaults = { lazy = false },
    install = { colorscheme = { "tokyonight", "habamax" } },
    -- checker = { enabled = true },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }
)

local viewConfig = require("lazy.view.config")

viewConfig.keys.details = "o"
viewConfig.commands.build.key_plugin = "r"

-- use("p00f/nvim-ts-rainbow")
-- use("nvim-treesitter/playground")
-- use("m-demare/hlargs.nvim")
-- use("/home/charles/Documents/dev/plugins/blaster")
-- use("ryvnf/readline.vim")
-- use("Julian/vim-textobj-variable-segment")
-- use("skywind3000/asyncrun.vim")
-- use({
--   'sindrets/diffview.nvim',
--   requires = 'nvim-lua/plenary.nvim',
-- })
-- use({
--   "jonatan-branting/nvim-better-n",
--   config = function()
--     require("setup").bettern()
--     require("mappings").bettern()
--   end
-- })
-- use({
--   "ggandor/leap.nvim",
--   config = function()
--     require("setup").leap()
--     require("mappings").leap()
--   end
-- })
-- use({
--   "cshuaimin/ssr.nvim",
--   module = "ssr",
--   config = function()
--     require('setup').ssr()
--     require('mappings').ssr()
--   end
-- })
