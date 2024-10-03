local vim = vim

return {
  enabled = true,

  -- 'Runeword/checker.nvim',

  dir = '~/.config/nvim/lua/myplugins/checker.nvim',

  config = function()
    vim.keymap.set('n', '<Up>',   require('checker').prevDiagnostic, { noremap = true, silent = true, })
    vim.keymap.set('n', '<Down>', require('checker').nextDiagnostic, { noremap = true, silent = true, })

    -- vim.keymap.set('n', '<PageUp>', vim.diagnostic.goto_prev, { buffer = buffer, })
    -- vim.keymap.set('n', '<PageDown>', vim.diagnostic.goto_next, { buffer = buffer, })
  end,
}
