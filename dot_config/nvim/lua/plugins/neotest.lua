local vim = vim

return {
  'nvim-neotest/neotest',
  enabled = false,

  dependencies = {
    'nvim-lua/plenary.nvim',
    'anuvyklack/hydra.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-go')({}),
      },
    })

    local mappings = require('hydra')({
      mode = { 'o', 'n', 'x', },

      config = {
        hint = { type = 'window', },
        color = 'pink',
        foreign_keys = 'run',
        exit = false,
      },

      heads = {
        { 't',     require('neotest').summary.toggle, },
        { 'r',     require('neotest').run.run, },
        { 'f',     function() require('neotest').run.run(vim.fn.expand('%')) end, },
        { 'd',     function() require('neotest').run.run({ strategy = 'dap', }) end, },
        { 's',     require('neotest').run.stop, },
        { 'a',     require('neotest').run.attach, },
        { 'q',     nil,                                                              { exit = true, }, },
        { '<Esc>', nil,                                                              { exit = true, }, },
      },
    })

    vim.keymap.set({ 'n', 'x', }, '<Leader>t', function() mappings:activate() end)
  end,
}
