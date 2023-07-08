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

    modes = {
      search = {
        enabled = false,
        highlight = {
          backdrop = false,
        },
        jump = {
          history = true,
          register = true,
          nohlsearch = true,
        },
      },

      char = {
        enabled = true,
        config = function(opts)
          opts.autohide = vim.fn.mode(true):find('no') and vim.v.operator == 'y'
          opts.jump_labels = opts.jump_labels and vim.v.count == 0
        end,
        autohide = false,
        jump_labels = false,
        multi_line = true,
        -- label = { exclude = 'hjkliardc', },
        keys = { 'f', 'F', 't', 'T', ';', ',', },
        char_actions = function(motion)
          return {
            [';'] = 'next',
            [','] = 'prev',
            [motion:lower()] = 'next',
            [motion:upper()] = 'prev',
          }
        end,
        search = { wrap = false, },
        highlight = { backdrop = false, },
        jump = { register = false, },
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
