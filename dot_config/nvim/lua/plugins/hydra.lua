local vim = vim

return {
  'nvimtools/hydra.nvim',
  enabled = false,

  init = function()
    vim.api.nvim_create_augroup('hydra', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'hydra',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'HydraHint', { fg = '#ffffff', bg = 'NONE', })
      end,
    })
  end,

  config = function()
    -- require('hydra')({
    --   name = 'newline',
    --   mode = { 'n', 'x', },
    --   body = 'g',
    --
    --   heads = {
    --     { 'o', '<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>', },
    --     { 'O', '<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>', },
    --   },
    -- })

    -------------------- Scroll
    local scroll = require('hydra')({
      mode = { 'n', 'x', },

      config = {
        hint = false,
        on_enter = function() vim.o.scrolloff = 9999 end,
        on_exit = function() vim.o.scrolloff = 5 end,
      },

      heads = {
        { 'u', '5k', },
        { 'e', '5j', },
      },
    })

    vim.keymap.set({ 'n', 'x', }, '<Leader>e',
      function()
        scroll:activate()
        vim.fn.execute('normal! 5j')
      end)

    vim.keymap.set({ 'n', 'x', }, '<Leader>u',
      function()
        scroll:activate()
        vim.fn.execute('normal! 5k')
      end)

    -------------------- Jump paragraph
    -- local nextParagraphStart = function()
    --   vim.fn.search(
    --     [[\(^$\n\s*\zs\S\)\|\(\S\ze\n*\%$\)]], 'sW')
    -- end

    -- local nextParagraphEnd = function()
    --   vim.fn.search([[\(\n\s*\)\@<=\S\(.*\n^$\)\@=]],
    --     'sW')
    -- end

    -- local prevParagraphStart = function()
    --   vim.fn.search(
    --     [[\(^$\n\s*\zs\S\)\|\(^\%1l\s*\zs\S\)]], 'sWb')
    -- end

    -- local prevParagraphEnd = function()
    --   vim.fn.search([[\(\n\s*\)\@<=\S\(.*\n^$\)\@=]],
    --     'sWb')
    -- end

    -- local jumpParagraph = require('hydra')({
    --   mode = { 'n', 'x', },

    --   config = {
    --     hint = false,
    --     on_enter = function() vim.o.scrolloff = 9999 end,
    --     on_exit = function() vim.o.scrolloff = 5 end,
    --   },

    --   heads = {
    --     { '<Down>',   nextParagraphStart, },
    --     { '<Up>',     prevParagraphStart, },
    --     { '<S-Up>',   prevParagraphEnd, },
    --     { '<S-Down>', nextParagraphEnd, },
    --   },
    -- })

    -- vim.keymap.set({ 'n', 'x', }, '<Down>',
    --   function()
    --     jumpParagraph:activate()
    --     nextParagraphStart()
    --   end)

    -- vim.keymap.set({ 'n', 'x', }, '<Up>',
    --   function()
    --     jumpParagraph:activate()
    --     prevParagraphStart()
    --   end)

    -- vim.keymap.set({ 'n', 'x', }, '<S-Up>',
    --   function()
    --     jumpParagraph:activate()
    --     prevParagraphEnd()
    --   end)

    -- vim.keymap.set({ 'n', 'x', }, '<S-Down>',
    --   function()
    --     jumpParagraph:activate()
    --     nextParagraphEnd()
    --   end)
  end,
}
