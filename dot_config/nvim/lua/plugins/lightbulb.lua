return {
  'kosayoda/nvim-lightbulb',
  enabled = false,

  config = function()
    require('nvim-lightbulb').setup({
      sign = {
        enabled = false,
      },
      virtual_text = {
        enabled = true,
        text = '',
        pos = 'eol',
        hl = 'LightBulbVirtualText',
        hl_mode = 'combine',
      },
      autocmd = {
        enabled = true,
        updatetime = 50,
        events = { 'CursorHold', 'CursorHoldI', },
        pattern = { '*', },
      },
    })
  end,
}
