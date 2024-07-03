return {
  'OXY2DEV/markview.nvim',

  enabled = true,

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('markview').setup();
  end,
}
