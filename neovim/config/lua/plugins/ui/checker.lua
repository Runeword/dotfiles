local vim = vim

return {
  enabled = true,

  -- 'Runeword/checker.nvim',

  dir = vim.fn.stdpath('config') .. '/lua/myplugins/checker.nvim',

  config = function()
    vim.keymap.set('n', '<PageUp>', require('checker').prevDiagnostic, { noremap = true, silent = true, })
    vim.keymap.set('n', '<PageDown>', require('checker').nextDiagnostic, { noremap = true, silent = true, })

    -- vim.keymap.set('n', '<PageUp>', vim.diagnostic.goto_prev, { buffer = buffer, })
    -- vim.keymap.set('n', '<PageDown>', vim.diagnostic.goto_next, { buffer = buffer, })
  end,
}
