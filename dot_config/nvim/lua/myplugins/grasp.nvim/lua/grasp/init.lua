local api = vim.api
local ts = vim.treesitter

local M = {}

function M.select_treesitter_node_under_cursor()
  local current_buffer_id = api.nvim_get_current_buf()
  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_line = cursor_pos[1] - 1 -- Convert row to 0-based index
  local cursor_col = cursor_pos[2]

  -- Cache the language tree
  local lang_tree = ts.get_parser(current_buffer_id)
  if not lang_tree then return end

  -- Get the tree for the current position
  local tree = lang_tree:tree_for_range({ cursor_line, cursor_col, cursor_line, cursor_col })
  if not tree then return end

  -- Find the smallest named node at the cursor position
  local node = tree:root():named_descendant_for_range(cursor_line, cursor_col, cursor_line, cursor_col)
  if not node then return end

  -- Get the node's range
  local start_row, start_col, end_row, end_col = node:range()

  -- Set marks for the start and end of the node
  api.nvim_buf_set_mark(current_buffer_id, '<', start_row + 1, start_col, {})
  api.nvim_buf_set_mark(current_buffer_id, '>', end_row + 1, end_col - 1, {})

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

local function highlight_treesitter_node()
  -- Clear previous highlights
  api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)

  local current_buffer_id = api.nvim_get_current_buf()

  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_line = cursor_pos[1] - 1 -- API uses 0-based rows
  local cursor_col = cursor_pos[2]

  -- Get the treesitter parser and tree for the current buffer
  local success, ts_parser = pcall(ts.get_parser, current_buffer_id)
  if not success then return end

  local ts_tree = ts_parser:parse()[1]

  -- Get the node at the cursor position
  local ts_node = ts_tree:root():named_descendant_for_range(cursor_line, cursor_col, cursor_line, cursor_col)

  if ts_node then
    -- Get the range of the node
    local start_row, start_col, end_row, end_col = ts_node:range()

    -- Highlight the node
    api.nvim_buf_set_extmark(current_buffer_id, namespace_id, start_row, start_col, {
      end_row = end_row,
      end_col = end_col,
      hl_group = 'TreesitterObjectHighlight',
    })
  end
end

api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', }, {
  group = api.nvim_create_augroup('TreesitterObjectHighlight', { clear = true, }),
  callback = highlight_treesitter_node,
})

return M
