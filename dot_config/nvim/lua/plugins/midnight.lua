local vim = vim

return {
  'dasupradyumna/midnight.nvim',

  lazy = false,

  priority = 1000,

  init = function()
    -- autocommand will have no effect on previously sourced colorschemes
    -- so it must be added before any colorscheme is sourced
    -- require('autocmd').bufferline()
    -- require('autocmd').matchup()
    -- require('autocmd').flash()
    -- require('autocmd').sj()

    vim.cmd.colorscheme 'midnight'
  end,
}
