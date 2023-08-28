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
        vim.api.nvim_set_hl(0, 'HighlightUndo', { bg = '#e4e8f2', fg = 'black', })
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

    -- vim.api.nvim_create_augroup('cmp', { clear = true, })
    -- vim.api.nvim_create_autocmd('ColorScheme', {
    --   group = 'cmp',
    --   pattern = '*',
    --   callback = function()
    --     -- vim.api.nvim_set_hl(0, 'PmenuSel',                 { bg = '#282C34', fg = 'NONE', })
    --     -- vim.api.nvim_set_hl(0, 'Pmenu',                    { fg = '#C5CDD9', bg = '#22252A', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated',    { fg = '#7E8294', bg = 'NONE', strikethrough = true, })
    --     vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch',         { fg = '#82AAFF', bg = 'NONE', bold = true, })
    --     vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy',    { fg = '#82AAFF', bg = 'NONE', bold = true, })
    --     vim.api.nvim_set_hl(0, 'CmpItemMenu',              { fg = '#C792EA', bg = 'NONE', italic = true, })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindField',         { fg = '#EED8DA', bg = '#B5585F', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindProperty',      { fg = '#EED8DA', bg = '#B5585F', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindEvent',         { fg = '#EED8DA', bg = '#B5585F', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindText',          { fg = '#C3E88D', bg = '#9FBD73', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindEnum',          { fg = '#C3E88D', bg = '#9FBD73', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindKeyword',       { fg = '#C3E88D', bg = '#9FBD73', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindConstant',      { fg = '#FFE082', bg = '#D4BB6C', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindConstructor',   { fg = '#FFE082', bg = '#D4BB6C', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindReference',     { fg = '#FFE082', bg = '#D4BB6C', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindFunction',      { fg = '#EADFF0', bg = '#A377BF', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindStruct',        { fg = '#EADFF0', bg = '#A377BF', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindClass',         { fg = '#EADFF0', bg = '#A377BF', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindModule',        { fg = '#EADFF0', bg = '#A377BF', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindOperator',      { fg = '#EADFF0', bg = '#A377BF', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindVariable',      { fg = '#C5CDD9', bg = '#7E8294', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindFile',          { fg = '#C5CDD9', bg = '#7E8294', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindUnit',          { fg = '#F5EBD9', bg = '#D4A959', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindSnippet',       { fg = '#F5EBD9', bg = '#D4A959', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindFolder',        { fg = '#F5EBD9', bg = '#D4A959', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindMethod',        { fg = '#DDE5F5', bg = '#6C8ED4', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindValue',         { fg = '#DDE5F5', bg = '#6C8ED4', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember',    { fg = '#DDE5F5', bg = '#6C8ED4', })
    --
    --     vim.api.nvim_set_hl(0, 'CmpItemKindInterface',     { fg = '#D8EEEB', bg = '#58B5A8', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindColor',         { fg = '#D8EEEB', bg = '#58B5A8', })
    --     vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8', })
    --   end,
    -- })

    vim.cmd.colorscheme 'midnight'
  end,
}
