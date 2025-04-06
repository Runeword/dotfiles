local vim = vim

return {
  enabled = true,

  -- 'Runeword/appender.nvim',

  dir = vim.fn.stdpath("config") .. "/lua/myplugins/appender.nvim",

  config = function()
    vim.keymap.set({ 'x', 'n', }, 'ga', require('appender').appendCharEndLine,   { expr = true, })
    vim.keymap.set({ 'x', 'n', }, 'gi', require('appender').appendCharStartLine, { expr = true, })
    -- vim.keymap.set({ 'x', 'n', }, 'ra', require('appender').appendCharAfterCursor,  { expr = true, })
    -- vim.keymap.set({ 'x', 'n', }, 'ri', require('appender').appendCharBeforeCursor, { expr = true, })
    vim.keymap.set({ 'n', }, 'go', require('appender').appendNewlineBelow, { expr = true, })
    vim.keymap.set({ 'n', }, 'gO', require('appender').appendNewlineAbove, { expr = true, })
  end,
}
