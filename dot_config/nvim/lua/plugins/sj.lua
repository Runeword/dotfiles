local vim = vim

return {
  enabled = false,

  'woosaaahh/sj.nvim',

  config = function()
    require('sj').setup({
      auto_jump = false,
      forward_search = true,
      highlights_timeout = 0,
      max_pattern_length = 0,
      pattern_type = 'vim',
      preserve_highlights = true,
      prompt_prefix = '',
      relative_labels = false,
      search_scope = 'visible_lines',
      separator = '',
      update_search_register = false,
      use_last_pattern = false,
      use_overlay = false,
      wrap_jumps = vim.o.wrapscan,

      labels = {
        "'", ',', 'p', 'y', 'a', 'o', 'e', 'u', 'i', 'd', 'h', 't',
        'n', 's', 'f', 'g', 'c', 'r', 'l', ';', 'q', 'j', 'k', 'x', 'b',
        'm', 'w', 'v', 'z',
      },

      keymaps = {
        cancel = '<Esc>',
        validate = '<Tab>',
        prev_match = '<S-Enter>',
        next_match = '<Enter>',
        prev_pattern = '<C-p>',
        next_pattern = '<C-n>',
        delete_prev_char = '<BS>',
        delete_prev_word = '<C-w>',
        delete_pattern = '<C-u>',
        restore_pattern = '<A-BS>',
        send_to_qflist = '<A-q>',
      },
    })

    vim.keymap.set({ 'n', 'o', 'x', }, 's', require('sj').run)
  end,
}
