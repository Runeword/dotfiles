require("autocmd").core()
require("options").core()
require("mappings").core()

return require("packer").startup({
  function(use)
    use("lewis6991/impatient.nvim")
    use({
      "wbthomason/packer.nvim",
      config = function()
        require("mappings").packer()
        require("autocmd").packer()
      end,
    })
    use("nvim-lua/plenary.nvim")
    use("kyazdani42/nvim-web-devicons")
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("options").tokyonight()
      end,
    })
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("setup").treesitter()
      end,
      run = ":TSUpdate",
    })
    use("neovim/nvim-lspconfig")
    use({
      "williamboman/nvim-lsp-installer",
      config = require("config.lsp")()
      -- config = function()
      --   require("setup").installer()
      --   require("config.lsp")
      -- end,
    })
    use({
      'anuvyklack/hydra.nvim',
      requires = 'anuvyklack/keymap-layer.nvim',
      config = function()
        require("mappings").hydra()
      end,
    })
    use({
      "ms-jpq/coq_nvim",
      branch = "coq",
      config = require("config.coq")(),
      requires = { "ms-jpq/coq.artifacts", branch = "artifacts" },
    })
    use({
      "is0n/fm-nvim",
      config = function()
        require("mappings").fm()
        require("setup").fm()
      end,
    })
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("setup").gitsigns()
      end,
    })
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("setup").colorizer()
      end,
    })
    use({
      "nacro90/numb.nvim",
      config = function()
        require("setup").numb()
      end,
    })
    use({
      "echasnovski/mini.nvim",
      config = function()
        require("autocmd").indentscope()
        require("setup").indentscope()
      end,
    })
    use({
      "jessekelighine/vindent.vim",
      config = function()
        require("mappings").vindent()
      end,
    })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("windwp/nvim-ts-autotag")
    use("itchyny/vim-cursorword")
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("setup").comment()
      end,
    })
    use("tommcdo/vim-exchange")
    use({
      "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup()
      end,
    })
    use("p00f/nvim-ts-rainbow")
    use({
      "AndrewRadev/splitjoin.vim",
      config = function()
        require("mappings").splitjoin()
      end,
    })
    use({
      "wellle/targets.vim",
      config = function()
        require("mappings").targets()
        require("options").targets()
        require("autocmd").targets()
      end,
    })
    use({
      "windwp/nvim-autopairs",
      config = require("config.autopairs")(),
    })
    use({
      'akinsho/bufferline.nvim',
      config = function()
        require('mappings').bufferline()
        require('setup').bufferline()
      end
    })
    -- use({
    --   "ghillb/cybu.nvim",
    --   branch = "main",
    --   requires = { "kyazdani42/nvim-web-devicons" },
    --   config = function()
    --     require("setup").cybu()
    --     require("mappings").cybu()
    --   end,
    -- })
    use({
      "kana/vim-arpeggio",
      config = function()
        require("mappings").arpeggio()
      end,
    })
    use("rktjmp/lush.nvim")
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("setup").project()
      end,
    })
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = "require('config.lualine')()",
    })
    -- use({
    --   "gbprod/cutlass.nvim",
    --   config = function()
    --     require("setup").cutlass()
    --   end,
    -- })
    use({
      "ggandor/leap.nvim",
      config = function()
        require("options").leap()
        require("mappings").leap()
      end
    })
    -- use({
    --   "justinmk/vim-sneak",
    --   config = function()
    --     require("autocmd").sneak()
    --     require("options").sneak()
    --     require("mappings").sneak()
    --   end,
    -- })
    use("nvim-treesitter/playground")
    use({
      "ibhagwan/fzf-lua",
      config = function()
        require("mappings").fzf()
        require("setup").fzf()
      end,
    })
    use({
      "monaqa/dial.nvim",
      config = function()
        require("mappings").dial()
        require("options").dial()
      end,
    })
    use({
      "machakann/vim-highlightedyank",
      config = function()
        require("options").highlightedyank()
      end,
    })
    use("svban/YankAssassin.vim")
    use("glts/vim-textobj-comment")
    use({
      "D4KU/vim-textobj-chainmember",
      config = function()
        require("mappings").textobjchainmember()
      end,
    })
    use({
      "chaoren/vim-wordmotion",
      config = function()
        require("mappings").wordmotion()
        -- require("options").wordmotion()
      end,
    })
    use("kana/vim-textobj-line")
    -- use("Julian/vim-textobj-variable-segment")
    -- use({
    --   "jinh0/eyeliner.nvim",
    --   config = function()
    --     require("autocmd").eyeliner()
    --   end,
    -- })
    use({
      "kana/vim-textobj-user",
      config = function()
        require("options").textobjuser()
      end,
    })
    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({})
      end
    })
    -- use({
    --   "kana/vim-submode",
    --   config = function()
    --     require("options").submode()
    --     require("mappings").submode()
    --   end,
    -- })
    -- use({
    --   "RRethy/nvim-base16",
    --   config = function()
    --     require("setup").base16()
    --   end
    -- })
    -- use("/home/charles/Documents/dev/plugins/blaster")
    use({
      "/home/charles/Documents/dev/plugins/booster.nvim",
      -- "Runeword/booster.nvim",
      -- config = require("booster").setup(),
    })
    use("ryvnf/readline.vim")
    use("tpope/vim-abolish")
    -- use("tpope/vim-surround")
    -- use("m-demare/hlargs.nvim")
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({
          border = "",
          width = 999,
          height = 999,
        })
      end,
    },
    -- lewis6991/impatient.nvim
    -- compile_path = fn.stdpath("config") .. "/lua/packer_compiled.lua",
    -- profile = {
    -- 	enable = true,
    -- },
  },
})

-- use {
--   "folke/trouble.nvim",
--   requires = "kyazdani42/nvim-web-devicons",
--   -- config = function()
--   --   require("trouble").setup {
--   --   }
--   -- end
-- }
-- use({
--   "sbdchd/neoformat",
--   config = function()
--     require("options").neoformat()
--     require("autocmd").neoformat()
--   end,
-- })
-- use("tpope/vim-repeat")
-- use({
-- 	"jeetsukumaran/vim-indentwise",
-- 	config = config.indentwise(),
-- })
-- use({
-- 	"jeetsukumaran/vim-indentwise",
-- 	config = function()
-- 		require("mappings").indentwise()
-- 	end,
-- })
-- use("tpope/vim-commentary")
-- use("JoosepAlviste/nvim-ts-context-commentstring")
-- use("kana/vim-textobj-user")
-- use("PeterRincker/vim-argumentative")
-- use({
-- 	"inside/vim-search-pulse",
-- 	config = function()
-- 		require("setup").pulse()
-- 		require("mappings").pulse()
-- 	end,
-- })
-- use("michaeljsmith/vim-indent-object")
-- use({
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	-- config = require("setup").indentBlankline(),
-- })
-- use("Houl/repmo-vim")
-- use({
-- 	"andymass/vim-matchup",
-- })
-- use({
-- 	"rlane/pounce.nvim",
-- 	-- config = function()
-- 	-- 	require("setup").pounce()
-- 	-- 	require("mappings").pounce()
-- 	-- end,
-- })
-- use({
-- 	"phaazon/hop.nvim",
-- 	-- config = function()
-- 	-- 	require("setup").hop()
-- 	-- 	require("mappings").hop()
-- 	-- end,
-- })
-- use({
-- 	"nvim-telescope/telescope.nvim",
-- 	-- config = require("config.telescope").setup(),
-- })
-- use({
-- 	"svermeulen/vim-cutlass",
-- 	config = function()
-- 		require("mappings").cutlass()
-- 	end,
-- })
-- use("bfredl/nvim-incnormal")
-- use({
-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
-- 	config = function()
-- 		require("lsp_lines").register_lsp_virtual_lines()
-- 	end,
-- })
-- use({
-- 	"bfredl/nvim-miniyank",
-- 	config = function()
-- 		require("setup").miniyank()
-- 		require("mappings").miniyank()
-- 	end,
-- })
-- use("svermeulen/vim-yoink")
-- use("matze/vim-move")
-- use("RRethy/nvim-treesitter-textsubjects")
-- use({ "ibhagwan/fzf-lua", requires = { "vijaymarupudi/nvim-fzf" } })
-- use({ "rrethy/vim-hexokinase", run = "make hexokinase", cmd = "HexokinaseTurnOn" })
-- use({
-- "bkad/CamelCaseMotion",
-- config = function()
-- require("mappings").camelCaseMotion()
-- end,
-- })

-------------------- kana/vim-arpeggio
-- cmd("call arpeggio#map('i', '', 0, 'jk', '<Esc>')")

-------------------- matze/vim-move
-- cmd("let g:move_key_modifier = 'S'")

-------------------- AndrewRadev/sideways.vim
-- api.nvim_set_keymap("n", "<s-h>", ":SidewaysLeft<cr>", opts)
-- api.nvim_set_keymap("n", "<s-l>", ":SidewaysRight<cr>", opts)

-- -------------------- svermeulen/vim-yoink
-- cmd([[
-- nmap <c-n> <plug>(YoinkPostPasteSwapBack)
-- nmap <c-p> <plug>(YoinkPostPasteSwapForward)

-- nmap p <plug>(YoinkPaste_p)
-- nmap P <plug>(YoinkPaste_P)

-- " Also replace the default gp with yoink paste so we can toggle paste in this case too
-- nmap gp <plug>(YoinkPaste_gp)
-- nmap gP <plug>(YoinkPaste_gP)

-- let g:yoinkMaxItems = 5
-- let g:yoinkAutoFormatPaste = 1
-- let g:yoinkSwapClampAtEnds = 0
-- let g:yoinkSyncSystemClipboardOnFocus = 0
-- ]])
