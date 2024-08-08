local vim = vim

return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter',
  },

  {
    'nvim-treesitter/nvim-treesitter',

    build = ':TSUpdate',

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

        -- filNaj/tree-setter
        tree_setter = {
          enable = true,
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
              ['f'] = '@function.outer',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['F'] = '@call.outer',
              ['aF'] = '@call.outer',
              ['iF'] = '@call.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['ap'] = '@loop.outer',
              ['ip'] = '@loop.inner',
              ['s'] = '@statement.outer',
            },
          },

          -- move = {
          --   enable = true,
          --   set_jumps = true,
          -- goto_next_start = {
          --   [")"] = "@parameter.inner",
          -- },
          -- goto_previous_start = {
          --   ["("] = "@parameter.inner",
          -- },
          -- },
        },
      })

      -- vim.keymap.set({ 'o', 'x', }, 'ib', function()
      --   require('nvim-treesitter.textobjects.select').select_textobject('@block.inner')
      -- end)
      -- vim.keymap.set({ 'o', 'x', }, 'ab', function()
      --   require('nvim-treesitter.textobjects.select').select_textobject('@block.outer')
      -- end)
      vim.keymap.set({ 'o', }, 'b', 'ib', { remap = true, })
      vim.keymap.set({ 'o', }, 'p', 'ip', { remap = true, })
    end,
  },
}
