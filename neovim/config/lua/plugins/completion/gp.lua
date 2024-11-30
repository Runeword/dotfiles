return {
  'robitx/gp.nvim',

  config = function()
    require('gp').setup({
      openai_api_key = { 'pass', 'show', 'OPENAI_API_KEY', },

      providers = {
        openai = {},
        googleai = {
          disabled = false,
          endpoint =
          'https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}',
          secret = { 'pass', 'show', 'GEMINI_API_KEY', },
        },
      },
    })
  end,
}
