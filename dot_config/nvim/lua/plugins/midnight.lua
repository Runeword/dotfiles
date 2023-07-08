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
    -- require('autocmd').sj()

    -- folke/flash.nvim
    vim.api.nvim_create_augroup('flash', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'flash',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'FlashMatch',
          { bg = '#222b66', fg = 'white', bold = false, })
        vim.api.nvim_set_hl(0, 'FlashCurrent',
          { bg = '#ffe100', fg = 'black', bold = false, })
        vim.api.nvim_set_hl(0, 'FlashLabel',
          { bg = '#5d00ff', fg = 'white', bold = false, })
      end,
    })

    vim.cmd.colorscheme 'midnight'
  end,
}
