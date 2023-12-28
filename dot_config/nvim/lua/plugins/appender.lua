local vim = vim

return {
  enabled = true,

  -- 'Runeword/appender.nvim',

  dir = '~/.config/nvim/lua/myplugins/appender.nvim',

  config = function()
    vim.keymap.set({ 'x', 'n', }, 'ga', require('appender').appendCharEndLine,   { expr = true, })
    vim.keymap.set({ 'x', 'n', }, 'gi', require('appender').appendCharStartLine, { expr = true, })
    -- vim.keymap.set({ 'x', 'n', }, 'ra', require('appender').appendCharAfterCursor,  { expr = true, })
    -- vim.keymap.set({ 'x', 'n', }, 'ri', require('appender').appendCharBeforeCursor, { expr = true, })
  end,
}
