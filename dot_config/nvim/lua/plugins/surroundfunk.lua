local vim = vim

return {
  'Matt-A-Bennett/vim-surround-funk',
  config = function()
    vim.g.surround_funk_create_mappings = 0
    vim.cmd([[
      xmap <silent> an <Plug>(SelectFunctionName)
      omap <silent> an <Plug>(SelectFunctionName)
      xmap <silent> aN <Plug>(SelectFunctionNAME)
      omap <silent> aN <Plug>(SelectFunctionNAME)
      xmap <silent> in <Plug>(SelectFunctionName)
      omap <silent> in <Plug>(SelectFunctionName)
      xmap <silent> iN <Plug>(SelectFunctionNAME)
      omap <silent> iN <Plug>(SelectFunctionNAME)
      ]])
  end,
}
