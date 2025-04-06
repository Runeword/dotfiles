local vim = vim

return {
  dir = vim.fn.stdpath("config") .. "/lua/myplugins/grasp.nvim",

  config = function()
    vim.keymap.set({ 'x', 'o', }, '<Tab>',   require('grasp').select_treesitter_node_under_cursor)
    -- vim.keymap.set('n',           '<Tab>',   require('grasp').move_to_next_treesitter_node)
    -- vim.keymap.set('n',           '<S-Tab>', require('grasp').move_to_prev_treesitter_node)
  end,
}
