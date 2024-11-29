local vim = vim

return {
  'MagicDuck/grug-far.nvim',

  config = function()
    local grugFar = require('grug-far')

    grugFar.setup({});

    vim.keymap.set('n', 'R', function()
      local current_word = vim.fn.expand('<cword>')
      grugFar.open({ prefills = { search = current_word, }, })
    end, { desc = 'Open grug-far with current word', })
  end,
}
