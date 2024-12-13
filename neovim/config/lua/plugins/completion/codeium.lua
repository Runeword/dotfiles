local vim = vim

return {
  'Exafunction/codeium.vim',

  enabled = false,

  event = 'BufEnter',

  init = function()
    vim.api.nvim_create_augroup('codeium', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'codeium',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'CodeiumAnnotation', { bg = 'none', fg = '#5a7a99', italic = true, })
        vim.api.nvim_set_hl(0, 'CodeiumSuggestion', { bg = 'none', fg = '#5a7a99', italic = true, })
      end,
    })
  end,

  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.keymap.set('i', '<C-CR>', function() return vim.fn['codeium#Accept']() end, { expr = true, })
    -- vim.keymap.set('i', '<C-w>', function() return vim.fn['codeium#AcceptNextWord']() end, { expr = true, })
    -- vim.keymap.set('i', '<C-e>', function() return vim.fn['codeium#AcceptNextLine']() end, { expr = true, })
  end,
}
