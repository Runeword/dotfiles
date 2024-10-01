local vim = vim

return {
  'tzachar/local-highlight.nvim',

  config = function()
    require('local-highlight').setup()
  end,

  init = function()
    vim.api.nvim_create_augroup('localhighlight', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'localhighlight',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'LocalHighlight', { bg = '#1d253d', })
        -- vim.api.nvim_set_hl(0, 'LocalHighlight', { bg = '#1a1f30', })
      end,
    })
  end,
}
