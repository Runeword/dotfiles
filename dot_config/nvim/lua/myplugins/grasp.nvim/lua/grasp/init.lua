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
  local tree = lang_tree:tree_for_range({ row, col, row, col })
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

function M.move_to_next_treesitter_node()
  local current_buffer_id = api.nvim_get_current_buf()
  local current_buffer_filetype = api.nvim_get_option_value('filetype', { buf = current_buffer_id, })

  local ts_lang = ts.language.get_lang(current_buffer_filetype)
  if ts_lang == nil then
    return
  end

  local ts_parser = ts.get_parser(current_buffer_id, ts_lang)
  local ts_tree = ts_parser:parse()[1]
  local ts_query = ts.query.parse(ts_lang, '(_) @node')

  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_line = cursor_pos[1]
  local cursor_col = cursor_pos[2]

  for _, ts_node in ts_query:iter_captures(ts_tree:root(), current_buffer_id, cursor_line - 1) do
    local ts_range = { ts_node:range(), }
    local row_start = ts_range[1] + 1
    local col_start = ts_range[2]

    if row_start > cursor_line or (row_start == cursor_line and col_start > cursor_col) then
      api.nvim_win_set_cursor(0, { row_start, col_start, })
      break
    end
  end
end

function M.move_to_prev_treesitter_node()
  local current_buffer_id = api.nvim_get_current_buf()
  local current_buffer_filetype = api.nvim_get_option_value('filetype', { buf = current_buffer_id, })

  local ts_lang = ts.language.get_lang(current_buffer_filetype)
  if ts_lang == nil then
    return
  end

  local ts_parser = ts.get_parser(current_buffer_id, ts_lang)
  local ts_tree = ts_parser:parse()[1]
  local ts_query = ts.query.parse(ts_lang, '(_) @node')

  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_line = cursor_pos[1]
  local cursor_col = cursor_pos[2]

  local ts_nodes = {}
  for _, ts_node in ts_query:iter_captures(ts_tree:root(), current_buffer_id, 0, cursor_line) do
    table.insert(ts_nodes, 1, ts_node)
  end

  for i = 1, #ts_nodes do
    local ts_range = { ts_nodes[i]:range(), }
    local row_start = ts_range[1] + 1
    local col_start = ts_range[2]

    if row_start < cursor_line or (row_start == cursor_line and col_start < cursor_col) then
      api.nvim_win_set_cursor(0, { row_start, col_start, })
      break
    end
  end
end

local namespace_id = api.nvim_create_namespace('TreesitterObjectHighlight')

local function highlight_treesitter_object()
  -- Clear previous highlights
  api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)

  -- Get current buffer and cursor position
  local bufnr = api.nvim_get_current_buf()
  local cursor_pos = api.nvim_win_get_cursor(0)
  local row = cursor_pos[1]
  local col = cursor_pos[2]
  row = row - 1 -- API uses 0-based rows


  -- Get the treesitter parser and tree for the current buffer
  local success, parser = pcall(ts.get_parser, bufnr)
  if not success then return end

  local tree = parser:parse()[1]

  -- Get the node at the cursor position
  local root = tree:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  if node then
    -- Get the range of the node
    local start_row, start_col, end_row, end_col = node:range()

    -- Highlight the node
    api.nvim_buf_set_extmark(bufnr, namespace_id, start_row, start_col, {
      end_row = end_row,
      end_col = end_col,
      hl_group = 'TreesitterObjectHighlight',
    })
  end
end

api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', }, {
  group = api.nvim_create_augroup('TreesitterObjectHighlight', { clear = true, }),
  callback = highlight_treesitter_object,
})

return M
