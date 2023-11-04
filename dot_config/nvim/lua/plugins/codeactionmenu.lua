local vim = vim

return {
  enabled = true,
  'weilbith/nvim-code-action-menu',

  config = function()
    vim.g.code_action_menu_show_details = false
    vim.g.code_action_menu_show_diff = true
    vim.g.code_action_menu_window_border = {
      { ' ', 'FloatBorder', },
      { ' ', 'FloatBorder', },
      { ' ', 'FloatBorder', },
      { ' ', 'FloatBorder', },
      { ' ', 'FloatBorder', },
      { ' ', 'FloatBorder', },
      { ' ', 'FloatBorder', },
      { ' ', 'FloatBorder', },
    }
  end,

  cmd = 'CodeActionMenu',

  vim.keymap.set('n', '<Leader>a', '<cmd>CodeActionMenu<Enter>')
}
