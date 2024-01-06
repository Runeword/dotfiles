local vim = vim

return {
  'dasupradyumna/midnight.nvim',
  -- autocommand will have no effect on previously sourced colorschemes
  -- so it must be added before any colorscheme is sourced :
  -- Use init function to add autocmd highlights
  -- Use config function to add the colorscheme

  config = function()
    vim.cmd.colorscheme 'midnight'
  end,

  lazy = false,
  priority = 1000,

  init = function()
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
  end,
}
