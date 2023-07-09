return {
  'kylechui/nvim-surround',

  config = function()
    require('nvim-surround').setup({
      keymaps = {
        insert = false,
        insert_line = false,
        normal_line = false,
        normal_cur_line = false,
        visual_line = false,
        normal_cur = 'ys',
        normal = 's',
        delete = 'ds',
        change = 'cs',
        visual = 's',
      },
    })
  end,
}
