local vim = vim

return {
  'nvim-lualine/lualine.nvim',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local lualine = require('lualine')

    -- stylua: ignore
    local colors = {
      bg       = 'none',
      fg       = '#ffffff',
      darkblue = '#24304d',
      blue     = '#6f00ff',
      green    = '#00ff6a',
      red      = '#ff0055',
    }

    -- --- @param trunc_width number trunctates component when screen width is less then trunc_width
    -- --- @param trunc_len number truncates component to trunc_len number of chars
    -- --- @param hide_width number hides component when window width is smaller then hide_width
    -- --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
    -- --- return function that can format the component accordingly
    -- local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    --   return function(str)
    --     local win_width = vim.fn.winwidth(0)
    --     if hide_width and win_width < hide_width then
    --       return ''
    --     elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
    --       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    --     end
    --     return str
    --   end
    -- end

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local sectionLeft = {
      {
        'mode',
        padding = { left = 1, right = 2, },
        fmt = string.lower,
      },

      {
        'filename',
        cond = conditions.buffer_not_empty,
        file_status = false,
        newfile_status = true,
        path = 1,
        padding = { left = 0, right = 1, },
        symbols = {
          unnamed = 'unnamed',
          newfile = 'new',
        },
      },

      {
        'diagnostics',
        sources = { 'nvim_diagnostic', },
        symbols = { error = '', warn = '', hint = '', info = '', },
      },

      --------------------------- Mid section
      -- { "%=" },
    }

    local sectionRight = {
      {
        'diff',
        -- symbols = { added = " ", modified = " ", removed = " " },
        symbols = { added = '+', modified = '~', removed = '-', },
        -- diff_color = {
        -- 	added = { fg = colors.green },
        -- 	modified = { fg = colors.orange },
        -- 	removed = { fg = colors.red },
        -- },
        cond = conditions.hide_in_width,
      },

      {
        'branch',
        icons_enabled = false,
        icon = '',
        fmt = function(branchName)
          return branchName == '' and '' or branchName
        end,
        -- fmt = trunc(120, 60, 60, true),
        padding = { right = 1, left = 0, },
      },

      -- {
      -- "filesize",
      -- cond = conditions.buffer_not_empty,
      -- padding = { right = 0, left = 1 },
      -- },

      -- {
      -- "o:encoding",
      -- cond = conditions.hide_in_width,
      -- padding = { right = 0, left = 1 },
      -- },

      -- {
      -- "fileformat",
      -- icons_enabled = false,
      -- padding = { right = 0, left = 1 },
      -- },
    }

    -- local extension = { sections = { lualine_a = { "mode" } } }
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        always_divide_middle = true,
        globalstatus = true,
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg, }, },
          inactive = { c = { fg = colors.fg, bg = colors.bg, }, },
        },
      },

      sections = {
        -- These are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = sectionLeft,
        lualine_x = sectionRight,
      },

      inactive_sections = {
        -- These are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { 'quickfix', },
      -- extensions = { extension },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)

  end,
}
