local vim = vim

return {
  'monaqa/dial.nvim',

  config = function()
    vim.keymap.set('n', '<C-a>', require('dial.map').inc_normal())
    vim.keymap.set('n', '<C-x>', require('dial.map').dec_normal())
    vim.keymap.set('v', '<C-a>', require('dial.map').inc_visual())
    vim.keymap.set('v', '<C-x>', require('dial.map').dec_visual())
    vim.keymap.set('v', 'g<C-a>', require('dial.map').inc_gvisual())
    vim.keymap.set('v', 'g<C-x>', require('dial.map').dec_gvisual())

    local augend = require('dial.augend')
    require('dial.config').augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.decimal_int,
        augend.date.alias['%Y/%m/%d'],
        augend.semver.alias.semver,
        augend.constant.alias.bool,

        augend.constant.new({
          elements = { 'let', 'const', },
        }),

        augend.constant.new({
          elements = { '&&', '||', },
          word = false,
          cyclic = true,
        }),
      },
    })
  end,
}
