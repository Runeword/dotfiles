return {
  'gelguy/wilder.nvim',

  dependencies = { 'romgrk/fzy-lua-native', },

  rocks = 'pcre2',

  config = function()
    local wilder = require('wilder')

    wilder.setup({
      modes = { ':', },
      -- modes = { ':', '/', '?' },
      next_key = '<Tab>',
      previous_key = '<S-Tab>',
    })

    -- wilder.set_option('pipeline', {
    --   wilder.branch(
    --     wilder.cmdline_pipeline({
    --       fuzzy = 1,
    --       set_pcre2_pattern = 0,
    --     }),
    --     wilder.python_search_pipeline({
    --       pattern = 'fuzzy',
    --     })
    --   ),
    -- })

    -- wilder.set_option('noselect', 0)

    wilder.set_option('renderer', wilder.popupmenu_renderer({
      pumblend = 25,
      left = { ' ', wilder.popupmenu_devicons(), },
      right = { ' ', wilder.popupmenu_scrollbar(), },

      highlighter = {
        wilder.lua_pcre2_highlighter(),
        wilder.lua_fzy_highlighter(),
      },

      highlights = {
        accent = wilder.make_hl('WilderAccent', 'Pmenu',
          { { a = 1, }, { a = 1, }, { foreground = '#ff4d97', }, }),
      },
    }))
  end,
}
