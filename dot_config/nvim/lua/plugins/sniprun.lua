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

    vim.keymap.set({ 'n', 'v', }, '<leader>rr', '<Plug>SnipRun')
    vim.keymap.set('n', '<leader>re', '<Plug>SnipReset')
    vim.keymap.set('n', '<leader>rl', '<Plug>SnipLive')
    vim.keymap.set('n', '<leader>rc', '<Plug>SnipClose')
    vim.keymap.set('n', '<leader>ri', '<Plug>SnipInfo')
    vim.keymap.set('n', '<leader>rm', '<Plug>SnipReplMemoryClean')
  end,
}
