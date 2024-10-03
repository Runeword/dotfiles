local vim = vim

return {
  'rcarriga/nvim-notify',
  enabled = true,

  init = function()
  end,

  config = function()
    require('notify').setup({
      top_down = false,
      stages = 'static',
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = 'single', })
      end,
    })

    vim.notify = require('notify')
  end,
}
