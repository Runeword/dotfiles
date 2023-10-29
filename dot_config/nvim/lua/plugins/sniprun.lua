local vim = vim

return {
  'michaelb/sniprun',

  build = 'sh ./install.sh',

  config = function()
    require('sniprun').setup({
      snipruncolors = {
        SniprunVirtualTextOk  = { bg = 'black', fg = 'white', },
        SniprunVirtualTextErr = { bg = 'black', fg = 'white', },
      },
      live_mode_toggle = 'enable',
    })

    vim.keymap.set({ 'n', 'v' }, '<Leader>rr', '<Plug>SnipRun')
    vim.keymap.set('n', '<Leader>re', '<Plug>SnipReset')
    vim.keymap.set('n', 'gr', '<Plug>SnipRunOperator')
    vim.keymap.set('n', '<Leader>rl', '<Plug>SnipLive')
    vim.keymap.set('n', '<Leader>rc', '<Plug>SnipClose')
    vim.keymap.set('n', '<Leader>ri', '<Plug>SnipInfo')
    vim.keymap.set('n', '<Leader>rm', '<Plug>SnipReplMemoryClean')
    -- vim.keymap.set('n', '<Leader>ra', ":let b:caret=winsaveview() <CR> | :%SnipRun <CR>| :call winrestview(b:caret) <CR>", { silent = true, })
  end,
}
