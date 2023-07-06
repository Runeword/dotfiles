local vim = vim

return {
  'echasnovski/mini.indentscope',

  version = false,

  config = function()
    vim.api.nvim_create_augroup('indentscope', { clear = true, })

    vim.api.nvim_create_autocmd('FileType', {
      group = 'indentscope',
      pattern = '*',
      command =
      "if index(['help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'NvimTree', 'neo-tree', 'Trouble'], &ft) != -1 || index(['nofile', 'terminal', 'lsp-installer', 'lspinfo'], &bt) != -1 | let b:miniindentscope_disable=v:true | endif",
    })

    local scope = require('mini.indentscope')
    scope.setup({
      draw = {
        delay = 0,
        animation = scope.gen_animation.none(),
      },

      mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = '',
        goto_bottom = '',
        -- goto_top = "<S-CR>",
        -- goto_bottom = "<CR>",
      },

      options = {
        border = 'both',
        indent_at_cursor = true,
        try_as_border = true,
      },

      symbol = '▏',
    })
  end,
}
