-- -- Create a namespace for our extmarks
-- local ns_id = api.nvim_create_namespace("node_type_labels")

-- -- Fallback mapping in case the textobjects module is not available
-- local fallback_map = {
--   ["function"] = "f",
--   ["class"] = "c",
--   ["loop"] = "l",
--   ["conditional"] = "i",
--   ["call"] = "m",
--   ["parameter"] = "a",
--   ["statement"] = "s",
--   ["comment"] = "/",
--   -- Add more mappings as needed
-- }

-- local function get_textobject_key(node, bufnr)
--   -- Try to load the textobjects module
--   local ok, textobjects = pcall(require, 'nvim-treesitter.textobjects.select')
--   if ok and textobjects and textobjects.textobject_at_point then
--     local objects = textobjects.textobject_at_point({ node = node, bufnr = bufnr })
--     for key, obj in pairs(objects) do
--       if obj:type() == node:type() then
--         return key
--       end
--     end
--   end

--   -- Fallback to our predefined map
--   return fallback_map[node:type()] or node:type():sub(1, 1)
-- end

-- function add_node_type_labels()
--   local bufnr = api.nvim_get_current_buf()
--   local row, col = unpack(api.nvim_win_get_cursor(0))
--   row = row - 1 -- Convert to 0-based index

--   api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

--   local success, parser = pcall(ts.get_parser, bufnr)
--   if not success then return end

--   local tree = parser:parse()[1]
--   local root = tree:root()

--   local node = root:named_descendant_for_range(row, col, row, col)
--   if not node then return end

--   while node do
--     local start_row, start_col, _, _ = node:range()

--     if start_row == row then
--       local label = get_textobject_key(node, bufnr)

--       api.nvim_buf_set_extmark(bufnr, ns_id, start_row, start_col, {
--         virt_text = { { label, "SpecialChar" } },
--         virt_text_pos = "overlay",
--         hl_mode = "combine",
--         priority = 100,
--       })
--     end

--     node = node:parent()
--   end
-- end

-- -- Set up an autocommand to run the function when the cursor moves
-- vim.cmd [[
--   augroup NodeTypeLabels
--     autocmd!
--     autocmd CursorMoved * lua add_node_type_labels()
--   augroup END
-- ]]

local api = vim.api
local ts = vim.treesitter

local M = {}

function M.select_treesitter_node_under_cursor()
  local current_buffer_id = api.nvim_get_current_buf()

  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_row = cursor_pos[1] - 1 -- Convert row to 0-based index
  local cursor_col = cursor_pos[2]

  local success, ts_parser = pcall(ts.get_parser, current_buffer_id)
  if not success then return end

  local ts_tree = ts_parser:tree_for_range({ cursor_row, cursor_col, cursor_row, cursor_col })

  -- Find the smallest named node at the cursor position
  local ts_node = ts_tree:root():named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

  -- Get the node's range
  local start_row, start_col, end_row, end_col = ts_node:range()

  -- Set marks for the start and end of the node
  api.nvim_buf_set_mark(current_buffer_id, '<', start_row + 1, start_col, {})
  api.nvim_buf_set_mark(current_buffer_id, '>', end_row + 1, end_col - 1, {})

  -- Visually select the node
  api.nvim_command('normal! gv')
end

function M.move_to_next_treesitter_node()
  local current_buffer_id = api.nvim_get_current_buf()
  local current_buffer_filetype = api.nvim_get_option_value('filetype', { buf = current_buffer_id, })

  local success, ts_parser = pcall(ts.get_parser, current_buffer_id)
  if not success then return end

  local ts_tree = ts_parser:parse()[1]
  local ts_lang = ts.language.get_lang(current_buffer_filetype)
  local ts_query = ts.query.parse(ts_lang, '(_) @node')

  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_row = cursor_pos[1]
  local cursor_col = cursor_pos[2]

  for _, ts_node in ts_query:iter_captures(ts_tree:root(), current_buffer_id, cursor_row - 1) do
    local ts_range = { ts_node:range(), }
    local row_start = ts_range[1] + 1
    local col_start = ts_range[2]

    if row_start > cursor_row or (row_start == cursor_row and col_start > cursor_col) then
      api.nvim_win_set_cursor(0, { row_start, col_start, })
      break
    end
  end
end

function M.move_to_prev_treesitter_node()
  local current_buffer_id = api.nvim_get_current_buf()
  local current_buffer_filetype = api.nvim_get_option_value('filetype', { buf = current_buffer_id, })

  local success, ts_parser = pcall(ts.get_parser, current_buffer_id)
  if not success then return end

  local ts_tree = ts_parser:parse()[1]
  local ts_lang = ts.language.get_lang(current_buffer_filetype)
  local ts_query = ts.query.parse(ts_lang, '(_) @node')

  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_row = cursor_pos[1]
  local cursor_col = cursor_pos[2]

  local ts_nodes = {}
  for _, ts_node in ts_query:iter_captures(ts_tree:root(), current_buffer_id, 0, cursor_row) do
    table.insert(ts_nodes, 1, ts_node)
  end

  for i = 1, #ts_nodes do
    local ts_range = { ts_nodes[i]:range(), }
    local row_start = ts_range[1] + 1
    local col_start = ts_range[2]

    if row_start < cursor_row or (row_start == cursor_row and col_start < cursor_col) then
      api.nvim_win_set_cursor(0, { row_start, col_start, })
      break
    end
  end
end

local namespace_id = api.nvim_create_namespace('TreesitterObjectHighlight')

local function highlight_treesitter_node()
  api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)

  if api.nvim_get_mode().mode ~= 'n' then return end

  local current_buffer_id = api.nvim_get_current_buf()

  local cursor_pos = api.nvim_win_get_cursor(0)
  local cursor_row = cursor_pos[1] - 1 -- API uses 0-based rows
  local cursor_col = cursor_pos[2]

  local success, ts_parser = pcall(ts.get_parser, current_buffer_id)
  if not success then return end

  local ts_tree = ts_parser:parse()[1]

  -- Get the node at the cursor position
  local ts_node = ts_tree:root():named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

  -- Get the range of the node
  local start_row, start_col, end_row, end_col = ts_node:range()

  -- Highlight the node
  api.nvim_buf_set_extmark(current_buffer_id, namespace_id, start_row, start_col, {
    end_row = end_row,
    end_col = end_col,
    hl_group = 'TreesitterObjectHighlight',
  })
end

api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
  group = api.nvim_create_augroup('TreesitterObjectHighlight', { clear = true, }),
  callback = highlight_treesitter_node,
})

return M
