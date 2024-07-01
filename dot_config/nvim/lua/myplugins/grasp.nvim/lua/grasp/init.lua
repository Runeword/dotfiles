local vim = vim

local M = {}

-- Function to select the node under the cursor
function M.select_node_under_cursor()
  -- Get the current buffer and cursor position
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  -- Get the parser and tree for the current buffer
  local parser = vim.treesitter.get_parser(bufnr)
  local tree = parser:parse()[1]

  -- Get the node at the cursor position
  local root = tree:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  if not node then return end

  -- Get the node's range
  local start_row, start_col, end_row, end_col = node:range()

  -- Set marks for the start and end of the node
  vim.api.nvim_buf_set_mark(bufnr, '<', start_row + 1, start_col, {})
  vim.api.nvim_buf_set_mark(bufnr, '>', end_row + 1, end_col, {})

  -- Visually select the node
  vim.cmd('normal! gv')
end

return M
