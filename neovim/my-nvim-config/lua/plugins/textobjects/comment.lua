local vim = vim

return {
  'numToStr/Comment.nvim',

  config = function()
    require('Comment').setup({ ignore = '^$', })

    vim.keymap.set('x', 'gc', '<Plug>(comment_toggle_linewise_visual)gv',  { remap = true, })
    vim.keymap.set('x', 'gb', '<Plug>(comment_toggle_blockwise_visual)gv', { remap = true, })
  end,
}
