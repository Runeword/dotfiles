local vim = vim

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'anuvyklack/hydra.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-go')({}),
      },
    })

    -- local mappings = require('hydra')({
    --   mode = { 'o', 'n', 'x', },

    --   config = {
    --     hint = { type = 'window', },
    --     color = 'pink',
    --     foreign_keys = 'run',
    --     exit = false,
    --   },

    --   heads = {
    --     -- { 'o',     require('neotest').summary.toggle(), },
    --     { 'q',     nil, { exit = true, }, },
    --     { '<Esc>', nil, { exit = true, }, },
    --   },
    -- })

    -- vim.keymap.set({ 'n', 'x', }, '<Leader>t', function() mappings:activate() end)
  end,
}
