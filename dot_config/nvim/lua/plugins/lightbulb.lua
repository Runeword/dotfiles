local vim = vim

return {
  'kosayoda/nvim-lightbulb',

  config = function()
    vim.fn.sign_define('LightBulbSign', { text = '💡', })

    vim.api.nvim_create_augroup('lightbulb', { clear = true, })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', },
      {
        group = 'lightbulb',
        pattern = '*',
        callback = require('nvim-lightbulb').update_lightbulb,
      })
  end,
}
