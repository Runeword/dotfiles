local vim = vim

return {
  'rcarriga/nvim-notify',

  init = function()
    -- vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#ffffff" })
  end,

  config = function()
    require('notify').setup({
      top_down = false,
      background_colour = '#000000',
      stages = 'static',
    })

    vim.notify = require('notify')
  end,
}
