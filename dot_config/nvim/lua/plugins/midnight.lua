local vim = vim

return {
  'dasupradyumna/midnight.nvim',

  lazy = false,

  priority = 1000,

  init = function()
    -- autocommand will have no effect on previously sourced colorschemes
    -- so it must be added before any colorscheme is sourced

    -- folke/flash.nvim
    vim.api.nvim_create_augroup('flash', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'flash',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'FlashMatch',   { bg = '#222b66', fg = 'white', bold = false, })
        vim.api.nvim_set_hl(0, 'FlashCurrent', { bg = '#FAFF00', fg = 'black', bold = false, })
        vim.api.nvim_set_hl(0, 'FlashLabel',   { bg = '#5d00ff', fg = 'white', bold = false, })
      end,
    })

    -- akinsho/bufferline.nvim
    vim.api.nvim_create_augroup('bufferline', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'bufferline',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'BufferLineFill',                 { bg = 'none', })
        vim.api.nvim_set_hl(0, 'BufferLineBackground',           { fg = '#7a7c9e', })
        vim.api.nvim_set_hl(0, 'BufferLineBufferSelected',       { fg = 'white', bg = 'none', })
        vim.api.nvim_set_hl(0, 'BufferLineNumbers',              { fg = '#7a7c9e', bg = 'none', italic = false, })
        vim.api.nvim_set_hl(0, 'BufferLineNumbersSelected',      { fg = 'white', bg = 'none', italic = false, })
        vim.api.nvim_set_hl(0, 'BufferLineDuplicate',            { fg = '#7a7c9e', bg = 'none', italic = false, })
        vim.api.nvim_set_hl(0, 'BufferLineDuplicateSelected',    { fg = 'white', bg = 'none', italic = false, })
        vim.api.nvim_set_hl(0, 'BufferLineTab',                  { fg = '#7a7c9e', bg = 'none', })
        vim.api.nvim_set_hl(0, 'BufferLineTabSelected',          { fg = 'white', bg = 'none', })
        vim.api.nvim_set_hl(0, 'BufferLineTabSeparator',         { fg = 'black', bg = 'none', })
        vim.api.nvim_set_hl(0, 'BufferLineTabSeparatorSelected', { fg = 'black', bg = 'none', })
      end,
    })

    -- machakann/vim-highlightedyank
    vim.api.nvim_create_augroup('highlightedyank', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'highlightedyank',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { bg = '#00ffa2', fg = 'black', })
        -- vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { bg = '#ff1994', fg = 'black', })
      end,
    })

    -- echasnovski/mini.indentscope
    vim.api.nvim_create_augroup('indentscope', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'indentscope',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol',    { bg = 'none', fg = '#222b66', })
        vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbolOff', { bg = 'none', fg = '#222b66', })
      end,
    })

    vim.cmd.colorscheme 'midnight'
  end,
}
