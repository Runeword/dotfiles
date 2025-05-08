local vim = vim

return {
  'folke/flash.nvim',

  event = 'VeryLazy',

  opts = {
    labels = ',pyaoeuidhtnsfgcrl;qjkxbmwvz',
    label = {
      uppercase = false,
      after = { 0, 2, },
    },

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
      enabled = false,
      prefix = { { '>', 'FlashPromptIcon', }, },

      win_config = {
        relative = 'cursor',
        width = 2,
        height = 1,
        col = 1, -- 2 columns to the right of the cursor
        row = 0, -- 1 row below the cursor
        zindex = 1000,
      },

      -- win_config = {
      --   relative = 'win',
      --   width = 20,
      --   height = 1,
      --   col = math.ceil(vim.api.nvim_win_get_width(0) / 2),
      --   row = math.ceil(vim.api.nvim_win_get_height(0) / 2),
      --   zindex = 1000,
      -- },
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
          autojump = true,
        },
      },

      char = {
        enabled = false,
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
    vim.api.nvim_create_augroup('flash', { clear = true, })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'flash',
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, 'FlashMatch', { bg = '#222b66', fg = 'white', bold = false, })
        vim.api.nvim_set_hl(0, 'FlashCurrent', { bg = '#49f5b0', fg = 'black', bold = false, })
        vim.api.nvim_set_hl(0, 'FlashLabel', { bg = '#5d00ff', fg = 'white', bold = false, })
      end,
    })
  end,

  keys = {
    -- {
    --   't',
    --   mode = { 'n', 'x', 'o', },
    --   function()
    --     require('flash').jump({
    --       action = function(match)
    --         vim.api.nvim_win_set_cursor(0, { match.pos[1], match.pos[2] - 1, })
    --       end,
    --     })
    --   end,
    --   desc = 'Flash',
    -- },
    {
      't',
      mode = { 'n', 'x', 'o', },
      function()
        require('flash').jump({
          search = {
            -- labels = ',pyaoeuidhtnsfgcrl;qjkxbmwvz',
            -- incremental = true,
          },
        })
      end,
      desc = 'Flash',
    },
    {
      '<C-t>',
      mode = { 'i', },
      function() require('flash').jump() end,
      desc = 'Flash',
    },
  },
}
