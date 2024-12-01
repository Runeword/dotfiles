local vim = vim
return {
  'robitx/gp.nvim',

  config = function()
    require('gp').setup({
      -- openai_api_key = { 'pass', 'show', 'OPENAI_API_KEY', },

      providers = {
        openai = {},

        googleai = {
          disabled = false,
          secret = { 'pass', 'show', 'GEMINI_API_KEY', },
        },
      },
    })

    vim.keymap.set('n', '<Leader>c', '<cmd>:GpChatNew vsplit<CR>')
  end,
}
