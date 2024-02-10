return {
  'kosayoda/nvim-lightbulb',
  enabled = false,

  config = function()
    require('nvim-lightbulb').setup({
      autocmd = {
        enabled = true,
        updatetime = 50,
        events = { 'CursorHold', 'CursorHoldI', },
        pattern = { '*', },
      },
    })
  end,
}
