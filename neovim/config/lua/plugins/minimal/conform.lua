local vim = vim

return {
  'stevearc/conform.nvim',

  enabled = true,

  config = function()
    require('conform').setup({
      formatters_by_ft = {
        sh = { 'shfmt', 'shellharden', },
        zsh = { 'shfmt', 'shellharden', }, -- 'beautysh'
        python = { 'isort', 'black', },
        javascript = { 'prettier', },
        typescript = { 'prettier', },
        html = { 'prettier', },
        typescriptreact = { 'prettier', },
        go = { 'gofmt', },
      },

      formatters = {
        shfmt = {
          prepend_args = { '-i', '2', '-ci', },
        },
      },
    })

    vim.keymap.set({ 'n', 'x', }, '<Leader>f',
      function() require('conform').format({ async = true, lsp_fallback = true, }) end)
  end,
}
