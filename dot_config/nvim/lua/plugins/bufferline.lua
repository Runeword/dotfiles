local vim = vim

return {
  'akinsho/bufferline.nvim',

  config = function()
    vim.keymap.set({ 'n', 'x', }, '<tab>', '<cmd>BufferLineCycleNext<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<s-tab>', '<cmd>BufferLineCyclePrev<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<pageup>', '<cmd>BufferLineMovePrev<CR>',
      { silent = true, })
    vim.keymap.set({ 'n', 'x', }, '<pagedown>', '<cmd>BufferLineMoveNext<CR>',
      { silent = true, })

    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-1>',
      function() require('bufferline').go_to_buffer(1) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-2>',
      function() require('bufferline').go_to_buffer(2) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-3>',
      function() require('bufferline').go_to_buffer(3) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-4>',
      function() require('bufferline').go_to_buffer(4) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-5>',
      function() require('bufferline').go_to_buffer(5) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-6>',
      function() require('bufferline').go_to_buffer(6) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-7>',
      function() require('bufferline').go_to_buffer(7) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-8>',
      function() require('bufferline').go_to_buffer(8) end)
    vim.keymap.set({ 'n', 't', 'i', 'x', }, '<A-9>',
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
      },

      -- highlights = {
      -- numbers = { fg = '#7a7c9e', bg = 'none', italic = false },
      -- numbers_selected = { fg = 'white', bg = 'none', italic = false },
      -- }
    })
  end,
}
