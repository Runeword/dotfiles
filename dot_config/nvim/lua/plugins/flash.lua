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
  },

  keys = {
    {
      's',
      mode = { 'n', 'x', 'o', },
      function() require('flash').jump() end,
      desc = 'Flash',
    },
  },
}
