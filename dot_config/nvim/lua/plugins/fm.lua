local vim = vim

return {
  enabled = false,

  'is0n/fm-nvim',

  config = function()
    vim.keymap.set('n', '<leader>n', '<cmd>Vifm<CR>')

    require('fm-nvim').setup({
      edit_cmd = 'edit',

      ui = {
        default = 'float',
        float = {
          border = 'none',
          float_hl = 'Normal',
          border_hl = 'FloatBorder',
          blend = 0,
          height = 999,
          width = 999,
        },
        split = {
          direction = 'topleft',
          size = 24,
        },
      },

      cmds = {
        vifm_cmd = 'vifm',
      },

      mappings = {
        -- vert_split = "<C-v>",
        -- horz_split = "<C-h>",
        -- tabedit = "<C-t>",
        -- edit = "<C-e>",
        -- ESC = "<ESC>",
      },
    })
  end,
}
