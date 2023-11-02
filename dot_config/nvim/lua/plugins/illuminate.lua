local vim = vim

return {
  'RRethy/vim-illuminate',
  config = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
      },
      filetypes_allowlist = {},
      modes_denylist = {},
      modes_allowlist = {},
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      under_cursor = true,
      large_file_cutoff = nil,
      large_file_overrides = nil,
      min_count_to_highlight = 1,
      should_enable = function(bufnr) return true end,
      case_insensitive_regex = false,
    })

    vim.keymap.del('n',           '<M-n>')
    vim.keymap.del('n',           '<M-p>')
    vim.keymap.del({ 'o', 'x', }, '<M-i>')

    vim.keymap.set('n',           '*',     function() require('illuminate').goto_next_reference() end, { remap = true })
    vim.keymap.set('n',           '#',     function() require('illuminate').goto_prev_reference() end, { remap = true })
    vim.keymap.set({ 'o', 'x', }, '<CR>',  function() require('illuminate').textobj_select() end)
  end,
}
