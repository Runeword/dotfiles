local vim = vim

return {
  'dasupradyumna/midnight.nvim',

  lazy = false,

  priority = 1000,

  init = function()
    -- autocommand will have no effect on previously sourced colorschemes
    -- so it must be added before any colorscheme is sourced

    -- andymass/vim-matchup
    vim.api.nvim_create_augroup('matchup', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'matchup',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'MatchParen',
          { fg = '#7429ff', italic = true, bold = true, })
        vim.api.nvim_set_hl(0, 'MatchWord',       { fg = '#7429ff', })
        vim.api.nvim_set_hl(0, 'MatchBackground', { bg = '#1a1a3b', })
      end,
    })


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

    -- tzachar/highlight-undo.nvim
    vim.api.nvim_create_augroup('highlightundo', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'highlightundo',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'HighlightUndo', { bg = '#222b66', fg = 'none', })
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

    -- Exafunction/codeium.vim
    vim.api.nvim_create_augroup('codeium', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'codeium',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'CodeiumAnnotation', { bg = 'none', fg = '#5a7a99', italic = true, })
        vim.api.nvim_set_hl(0, 'CodeiumSuggestion', { bg = 'none', fg = '#5a7a99', italic = true, })
      end,
    })

    -- hrsh7th/nvim-cmp
    vim.api.nvim_create_augroup('cmp', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'cmp',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'PmenuSel',                 { fg = 'NONE', bg = '#323f5c', })
        vim.api.nvim_set_hl(0, 'Pmenu',                    { fg = '#e4e8f2', bg = '#1e273b', })

        vim.api.nvim_set_hl(0, 'CmpItemKind',              { fg = '#e4e8f2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemAbbr',              { fg = '#e4e8f2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated',    { fg = '#00ffa2', bg = 'NONE', strikethrough = true, })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch',         { fg = '#00ffa2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy',    { fg = '#00ffa2', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemMenu',              { fg = '#e4e8f2', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindField',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindProperty',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindEvent',         { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindText',          { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindEnum',          { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindKeyword',       { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindConstant',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindConstructor',   { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindReference',     { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindFunction',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindStruct',        { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindClass',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindModule',        { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindOperator',      { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindVariable',      { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindFile',          { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindUnit',          { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindSnippet',       { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindFolder',        { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindMethod',        { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindValue',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember',    { fg = 'NONE', bg = 'NONE', })

        vim.api.nvim_set_hl(0, 'CmpItemKindInterface',     { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindColor',         { fg = 'NONE', bg = 'NONE', })
        vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = 'NONE', bg = 'NONE', })
      end,
    })

    vim.cmd.colorscheme 'midnight'
  end,
}
