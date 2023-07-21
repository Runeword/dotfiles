local vim = vim

return {
  enabled = true,
  'gbprod/yanky.nvim',

  config = function()
    require('yanky').setup({
      ring = {
        history_length = 100,
        storage = 'shada',
        sync_with_numbered_registers = true,
        cancel_event = 'update',
      },

      picker = {
        select = {
          action = nil,
        },
        telescope = {
          use_default_mappings = false,
          mappings = nil,
        },
      },

      system_clipboard = {
        sync_with_ring = true,
      },

      highlight = {
        on_put = true,
        on_yank = true,
        timer = 150,
      },

      preserve_cursor_position = {
        enabled = true,
      },
    })

    -- vim.keymap.set({ 'n', 'x', }, 'p', '<Plug>(YankyPutAfter)')
    vim.keymap.set('n', 'p', '<Plug>(YankyPutAfter)')
    vim.keymap.set('x', 'p', '"_d<Plug>(YankyPutBefore)')
    vim.keymap.set({ 'n', 'x', }, 'P', '<Plug>(YankyPutBefore)')
    vim.keymap.set('n', 'gp', '<Plug>(YankyPutIndentAfterLinewise)')
    vim.keymap.set('n', 'gP', '<Plug>(YankyPutIndentBeforeLinewise)')
    vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleForward)')
    vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleBackward)')
  end,
}
