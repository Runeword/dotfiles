local vim = vim

return {
  'Exafunction/codeium.vim',
  enabled = false,
  event = 'BufEnter',

  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.keymap.set('i', '<C-CR>', function() return vim.fn['codeium#Accept']() end, { expr = true, })
  end,
}
