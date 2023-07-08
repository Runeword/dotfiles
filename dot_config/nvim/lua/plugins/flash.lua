local vim = vim

return {
  'folke/flash.nvim',

  event = 'VeryLazy',

  opts = {
    labels = "',pyaoeuidhtnsfgcrl;qjkxbmwvz",
    label = { uppercase = false, },
    highlight = {
      backdrop = false,
      matches = true,
      priority = 5000,
      groups = {
        match = 'FlashMatch',
        current = 'FlashCurrent',
        backdrop = 'FlashBackdrop',
        label = 'FlashLabel',
      },
    },

    prompt = {
      enabled = true,
      prefix = { { '🦘 ', 'FlashPromptIcon', }, },
      win_config = {
        relative = 'win',
        width = 20,
        height = 1,
        col = math.ceil(vim.api.nvim_win_get_width(0) / 2),
        row = math.ceil(vim.api.nvim_win_get_height(0) / 2),
        zindex = 1000,
      },
    },
  },

  init = function()
  end,

  keys = {
    {
      's',
      mode = { 'n', 'x', 'o', },
      function() require('flash').jump() end,
      desc = 'Flash',
    },
  },
}
