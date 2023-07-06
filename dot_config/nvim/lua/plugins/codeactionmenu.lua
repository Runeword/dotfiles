local vim = vim

return {
  'weilbith/nvim-code-action-menu',

  config = function()
    -- vim.keymap.set("n", '<leader>ca', '<cmd>CodeActionMenu<Enter>')

    vim.g.code_action_menu_show_details = false
    vim.g.code_action_menu_show_diff = true
  end,

  cmd = 'CodeActionMenu',
}
