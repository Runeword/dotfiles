local vim = vim

return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        sh = { 'shfmt', 'shellharden', },
        zsh = { 'shfmt', 'shellharden', }, -- 'beautysh'
        -- null_ls.builtins.formatting.shfmt,
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.completion.spell,
      },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2', '-ci', },
        },
      },
    })
    vim.keymap.set({ 'n', }, '<Leader>f',
      function() require('conform').format({ async = true, lsp_fallback = true, }) end)
  end,
}
