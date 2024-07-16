local vim = vim

return {
  'haya14busa/vim-asterisk',
  dependencies = { 'inside/vim-search-pulse', },
  enabled = true,

  init = function()
    vim.g['asterisk#keeppos'] = 1
  end,

  config = function()
    vim.keymap.set('n', '*',    '<Plug>(asterisk-*)<Plug>Pulse')
    vim.keymap.set('n', '#',    '<Plug>(asterisk-#)<Plug>Pulse')
    vim.keymap.set('n', 'cn', '<Plug>(asterisk-z*)cgn')
    -- vim.keymap.set('n', '<BS>', '*``cgn')
    -- vim.keymap.set('n', '<S-BS>', '*``cgN')
  end,
}
