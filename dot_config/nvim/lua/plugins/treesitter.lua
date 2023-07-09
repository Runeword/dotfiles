return {
  'nvim-treesitter/nvim-treesitter',

  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',
      highlight = { enable = true, },
      indent = { enable = true, },
      autopairs = { enable = true, }, -- windwp/nvim-autopairs
      autotag = { enable = true, },   -- windwp/nvim-ts-autotag

      -- andymass/vim-matchup
      matchup = {
        enable = true,
        disable_virtual_text = true,
      },

      -- p00f/nvim-ts-rainbow
      rainbow = {
        enable = false,
        max_file_lines = nil,
        colors = {
          '#FF0048',
          '#B800FF',
          '#FAFF00',
        },
      },

      -- nvim-treesitter/nvim-treesitter-textobjects
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- ['f'] = '@function.outer',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['F'] = '@call.outer',
            ['aF'] = '@call.outer',
            ['iF'] = '@call.inner',
          },
        },

        move = {
          enable = true,
          set_jumps = true,
          -- goto_next_start = {
          --   [")"] = "@parameter.inner",
          -- },
          -- goto_previous_start = {
          --   ["("] = "@parameter.inner",
          -- },
        },
      },

      -- -- nvim-treesitter/playground
      -- playground = {
      --   enable = true,
      --   disable = {},
      --   updatetime = 25,       -- Debounced time for highlighting nodes in the playground from source code
      --   persist_queries = false, -- Whether the query persists across vim sessions
      --   keybindings = {
      --     toggle_query_editor = 'o',
      --     toggle_hl_groups = 'i',
      --     toggle_injected_languages = 't',
      --     toggle_anonymous_nodes = 'a',
      --     toggle_language_display = 'I',
      --     focus_language = 'f',
      --     unfocus_language = 'F',
      --     update = 'R',
      --     goto_node = '<cr>',
      --     show_help = '?',
      --   },
      -- },
    })
  end,

  build = ':TSUpdate',
}
