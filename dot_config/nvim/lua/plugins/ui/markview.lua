return {
  'OXY2DEV/markview.nvim',

  enabled = false,

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('markview').setup();
  end,
}
