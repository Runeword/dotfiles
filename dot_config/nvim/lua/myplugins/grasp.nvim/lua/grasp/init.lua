local api = vim.api
local ts = vim.treesitter

local M = {}

function M.select_node_under_cursor()
  local bufnr = api.nvim_get_current_buf()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2] -- Convert row to 0-based index

  -- Cache the language tree
  local lang_tree = ts.get_parser(bufnr)
  if not lang_tree then return end

  -- Get the tree for the current position
  local tree = lang_tree:tree_for_range({row, col, row, col})
  if not tree then return end

  -- Find the smallest named node at the cursor position
  local node = tree:root():named_descendant_for_range(row, col, row, col)
  if not node then return end

  -- Get the node's range
  local start_row, start_col, end_row, end_col = node:range()

  -- Set marks for the start and end of the node
  api.nvim_buf_set_mark(bufnr, '<', start_row + 1, start_col, {})
  api.nvim_buf_set_mark(bufnr, '>', end_row + 1, end_col - 1, {})

  -- Visually select the node
  api.nvim_command('normal! gv')
end

return M
