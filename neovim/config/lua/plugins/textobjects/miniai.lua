local vim = vim

return {
  'echasnovski/mini.ai',
  version = false,

  config = function()
    local gen_spec = require('mini.ai').gen_spec

    require('mini.ai').setup({
      custom_textobjects = {
        f = false,
        b = false,
        p = false,
        a = gen_spec.argument({ brackets = { '%b()', '%b{}', '%b[]', }, }),
        o = { { '%b()', '%b[]', '%b{}', '%b<>', }, '^.().*().$', },
        -- a = gen_spec.argument({ brackets = { '%b()' } }),
        -- o = gen_spec.argument({ brackets = { '%b{}' } }),
        -- e = gen_spec.argument({ brackets = { '%b[]' } }),
        -- A = gen_spec.pair('(', ')', { type = 'balanced' }),
        -- O = gen_spec.pair('{', '}', { type = 'balanced' }),
        -- E = gen_spec.pair('[', ']', { type = 'balanced' }),
        -- Q = gen_spec.pair('`', '`', { type = 'balanced' }),
      },

      mappings = {
        around = 'a',
        inside = 'i',
        -- around_next = 'an',
        -- inside_next = 'in',
        -- around_last = 'ao',
        -- inside_last = 'io',
        around_next = '',
        inside_next = '',
        around_last = '',
        inside_last = '',
        goto_left = '',
        goto_right = '',
      },

      n_lines = 100,
      search_method = 'cover_or_nearest',
    })

    vim.keymap.set({ 'o', 'x' }, 'o', 'io', { remap = true, })
  end,
}
