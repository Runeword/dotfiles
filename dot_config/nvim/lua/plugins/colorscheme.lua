local vim = vim

return {
  'bluz71/vim-nightfly-colors',

  -- autocommand will have no effect on previously sourced colorschemes
  -- so it must be added before any colorscheme is sourced :
  -- Use init function to add autocmd highlights
  -- Use config function to add the colorscheme

  config = function()
    vim.cmd.colorscheme('nightfly')
  end,

  lazy = false,

  priority = 1000,

  init = function()
    vim.g.nightflyTerminalColors = false

    vim.api.nvim_create_augroup('builtin', { clear = true, })
    vim.api.nvim_create_autocmd('colorscheme', {
      group = 'builtin',
      pattern = '*',
      callback = function()
        -- #0a172e #10141f #1a1a3b #1e2633 #424a57 #7a7c9e #222b66

        -- vim.api.nvim_set_hl(0, 'type',         { bold = true, })
        -- vim.api.nvim_set_hl(0, 'string',       { italic = true, bold = true, })
        -- vim.api.nvim_set_hl(0, 'keyword',      { italic = true, bold = true, })

        vim.api.nvim_set_hl(0, 'normalfloat',  { bg = '#1e2633', })
        vim.api.nvim_set_hl(0, 'floatborder',  { bg = '#1e2633', fg = '#1e2633', })

        vim.api.nvim_set_hl(0, 'pmenu',        { bg = 'black', fg = '#7a7c9e', })
        vim.api.nvim_set_hl(0, 'pmenusel',     { bg = '#1e2633', fg = 'white', })
        vim.api.nvim_set_hl(0, 'pmenusbar',    { bg = 'black', })
        vim.api.nvim_set_hl(0, 'pmenuthumb',   { bg = '#1e2633', })

        vim.api.nvim_set_hl(0, 'linenr',       { bg = 'none', fg = '#4b586e', })
        vim.api.nvim_set_hl(0, 'cursorlinenr', { bg = 'none', fg = 'white', })
        vim.api.nvim_set_hl(0, 'cursorline',   { bg = 'none', })
        vim.api.nvim_set_hl(0, 'cursorcolumn', { bg = '#1e2633', })

        vim.api.nvim_set_hl(0, 'search',       { bg = '#5d00ff', })
        vim.api.nvim_set_hl(0, 'CurSearch',    { bg = '#5d00ff', })
        vim.api.nvim_set_hl(0, 'incsearch',    { bg = '#faff00', fg = 'black', })
        vim.api.nvim_set_hl(0, 'normal',       { bg = 'none', })
        vim.api.nvim_set_hl(0, 'visual',       { bg = '#012749', })

        vim.api.nvim_set_hl(0, 'signcolumn',   { bg = 'none', })
        vim.api.nvim_set_hl(0, 'foldcolumn',   { bg = 'none', })
        vim.api.nvim_set_hl(0, 'folded',       { bg = 'none', })

        vim.api.nvim_set_hl(0, 'nontext',      { bg = 'none', fg = '#384354', })
        vim.api.nvim_set_hl(0, 'whitespace',   { bg = 'none', fg = '#384354', })

        vim.api.nvim_set_hl(0, 'VertSplit',    { bg = 'none', fg = '#1e2633', })

        vim.api.nvim_set_hl(0, 'Error',        { bg = 'none', fg = '#ff75a9', })
        vim.api.nvim_set_hl(0, 'ErrorMsg',     { bg = 'none', fg = '#ff75a9', })
        vim.api.nvim_set_hl(0, 'Warning',      { bg = 'none', fg = '#ff9d57', })
        vim.api.nvim_set_hl(0, 'WarningMsg',   { bg = 'none', fg = '#ff9d57', })
      end,
    })
  end,
}
