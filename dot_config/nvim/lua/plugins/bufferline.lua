local vim = vim

return {
  'akinsho/bufferline.nvim',

  init = function()
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
  end,

  config = function()
    vim.keymap.set('n', 'q',     '<cmd>silent bwipeout!<CR>')
    vim.keymap.set('n', '<C-t>', '<cmd>silent enew<CR>')
    -- vim.keymap.set('n', '<C-w>', '<cmd>silent bwipeout!<CR>')

    -- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, })
    -- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, })

    vim.keymap.set({ 'n', 'x', }, '<C-P>', '<cmd>BufferLineTogglePin<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<C-tab>', '<cmd>BufferLineCycleNext<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<C-S-tab>', '<cmd>BufferLineCyclePrev<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<C-PageDown>', '<cmd>BufferLineCycleNext<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<C-PageUp>', '<cmd>BufferLineCyclePrev<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<C-S-PageDown>', '<cmd>BufferLineMoveNext<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<C-S-PageUp>', '<cmd>BufferLineMovePrev<CR>',
      { silent = true, })

    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-1>',
      function() require('bufferline').go_to_buffer(1) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-2>',
      function() require('bufferline').go_to_buffer(2) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-3>',
      function() require('bufferline').go_to_buffer(3) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-4>',
      function() require('bufferline').go_to_buffer(4) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-5>',
      function() require('bufferline').go_to_buffer(5) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-6>',
      function() require('bufferline').go_to_buffer(6) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-7>',
      function() require('bufferline').go_to_buffer(7) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-8>',
      function() require('bufferline').go_to_buffer(8) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<C-9>',
      function() require('bufferline').go_to_buffer(-1) end)

    require('bufferline').setup({
      options = {
        numbers = function(opts)
          return string.format('%s', opts.raise(opts.ordinal))
        end,
        indicator = { style = 'none', },
        separator_style = { '', '', },
        tab_size = 0,
        buffer_close_icon = '',
        modified_icon = '',
        close_icon = '',
        groups = {
          items = {
            require('bufferline.groups').builtin.pinned:with({ icon = '', }),
          },
        },
      },
    })
  end,
}
