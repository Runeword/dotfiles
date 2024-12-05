local vim = vim

local M = {}

-------------------- Word

local function isEndOfWord()
  local pos = vim.fn.getpos('.')
  vim.print(pos)
  vim.fn.execute('normal! gee')
  vim.print(vim.fn.getpos('.'))
  if table.concat(pos) == table.concat(vim.fn.getpos('.')) then
    return true
  else
    vim.fn.setpos('.', pos)
    return false
  end
end

local function isStartOfWord()
  local pos = vim.fn.getpos('.')
  vim.print(pos)
  vim.fn.execute('normal! gew')
  vim.print(vim.fn.getpos('.'))
  if table.concat(pos) == table.concat(vim.fn.getpos('.')) then
    return true
  else
    vim.fn.setpos('.', pos)
    return false
  end
end

function M.putWordwise()
  return function()
    local command
    if isStartOfWord() and not isEndOfWord() then
      command = 'P'
    else
      command = 'p'
    end
    -- putCharwise(command)
  end
end

-------------------- Snap

local function isPastEndOfLine()
  return (vim.o.virtualedit ~= '') and (vim.fn.col('.') >= vim.fn.col('$'))
end

local function isBeforeFirstNonBlank()
  return (vim.o.virtualedit ~= '') and (vim.fn.col('.') <= string.find(vim.fn.getline(vim.fn.line('.')), '(%S)') - 1)
end

function M.snapToLineStart(callback)
  return function()
    if isBeforeFirstNonBlank() then vim.fn.execute('normal! ^') end
    if type(callback) == 'string' then vim.fn.execute('normal! ' .. callback) else callback() end
  end
end

function M.snapToLineEnd(callback)
  return function()
    if isPastEndOfLine() then vim.fn.execute('normal! $') end
    if type(callback) == 'string' then vim.fn.execute('normal! ' .. callback) else callback() end
  end
end

-------------------- Jump

local function jumpToLine(command, callback)
  if isPastEndOfLine() or isBeforeFirstNonBlank() then vim.fn.execute('normal! ' .. command) end
  if type(callback) == 'string' then vim.fn.execute('normal! ' .. callback) else callback() end
end

function M.jumpToLine(command, callback)
  return function() jumpToLine(command, callback) end
end

function M.jumpToLineStart(callback)
  return function() jumpToLine('^', callback) end
end

function M.jumpToLineEnd(callback)
  return function() jumpToLine('$', callback) end
end

-------------------- Move

function M.move_to_non_empty_line(lines)
  local new_line

  if lines > 0 then
    local nextParagraphStart = vim.fn.search([[\(^$\n\s*\zs\S\)\|\(\S\ze\n*\%$\)]], 'nW')
    local nextNonBlank = vim.fn.nextnonblank(vim.fn.line('.') + lines)
    new_line = nextNonBlank < nextParagraphStart and nextNonBlank or nextParagraphStart
  else
    local prevParagraphStart = vim.fn.search([[\(^$\n\s*\zs\S\)\|\(^\%1l\s*\zs\S\)]], 'nWb')
    local prevNonBlank = vim.fn.prevnonblank(vim.fn.line('.') + lines)
    new_line = prevNonBlank > prevParagraphStart and prevNonBlank or prevParagraphStart
  end

  -- Move the cursor to the first non-blank character of the line
  vim.fn.cursor(new_line, vim.fn.getline(new_line):find('%S') or 1)
end

-------------------- Undo

function M.undoAllChanges()
  if #vim.fn.undotree().entries == 0 then return end

  local output = vim.fn.execute('undo 0')

  vim.notify('' .. output:gsub('^\n', ''), 'info',
    { icon = '󰕌', render = 'wrapped-compact', timeout = 1200, })
end

function M.redoAllChanges()
  if #vim.fn.undotree().entries == 0 then return end

  local output = vim.fn.execute('undo ' .. vim.fn.undotree().seq_last)

  vim.notify('' .. output:gsub('^\n', ''), 'info',
    { icon = '󰑎', render = 'wrapped-compact', timeout = 1200, })
end

function M.deleteUndoTree()
  if #vim.fn.undotree().entries == 0 then return end

  local start = vim.fn.getpos("'[")
  local finish = vim.fn.getpos("']")

  local view = vim.fn.winsaveview()
  vim.o.undoreload = 0
  vim.cmd('edit')
  vim.fn.winrestview(view)

  vim.fn.setpos("'[", start)
  vim.fn.setpos("']", finish)

  vim.notify('Delete undo tree', 'info', { icon = '', render = 'wrapped-compact', timeout = 1200, })
end

-------------------- Edit

-- When the line is empty, move the cursor to the beginning of the line
function M.insert()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end

function M.visualSelectToEndOfline()
  local current_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { current_pos[1], #vim.api.nvim_get_current_line(), })
  vim.api.nvim_feedkeys('v', 'nx', false)
  vim.api.nvim_win_set_cursor(0, current_pos)
end

-------------------- Fold

local isFolded = false

function M.toggleFold()
  if not isFolded then
    vim.api.nvim_feedkeys('zR', 'n', false)
    isFolded = true
  else
    vim.api.nvim_feedkeys('zM', 'n', false)
    isFolded = false
  end
end

------------------- Buffers

-- Wipe all the active buffers, quit vim if it's the last buffer
function M.wipe_active_buffers()
  local buffers_count = 0
  local active_buffers = {}

  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buffer) then
      if vim.api.nvim_buf_get_option(buffer, 'buflisted') then
        buffers_count = buffers_count + 1
      end

      if vim.fn.bufwinid(buffer) ~= -1 then
        table.insert(active_buffers, buffer)
      end
    end
  end

  -- print(vim.inspect(active_buffers))

  for _, active_buffer in ipairs(active_buffers) do
    vim.api.nvim_buf_delete(active_buffer, { force = true, })
  end

  if buffers_count == 1 then
    vim.cmd('quit!')
  end
end

------------------- Windows

function M.cancel()
  -- Quit diagnostic window
  local buffer_id = vim.fn.bufnr('diagnostic_message')
  if buffer_id ~= -1 then
    vim.api.nvim_buf_delete(buffer_id, { force = true, unload = false, })
  end

  -- Quit messages window
  local bff = vim.fn.bufnr('messages')
  if bff ~= -1 then
    vim.api.nvim_buf_delete(bff, { force = true, unload = false, })
  end

  -- Move cursor to the beginning of the line
  vim.api.nvim_feedkeys(string.format('%c%s', 27, 'g^'), 'n', true) -- <Esc>g^
end

------------------- Messages

-- Display messages in a floating window
function M.displayMessages()
  local messages_string = vim.fn.split(vim.api.nvim_exec2('silent messages', { output = true, }).output, '\n')
  if next(messages_string) == nil then return end

  local buffer_id = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buffer_id, 'messages')

  vim.api.nvim_buf_set_lines(buffer_id, 0, -1, false, messages_string)

  local width = 80
  local height = #messages_string

  local window_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
  }

  vim.api.nvim_set_option_value('modifiable', false, { buf = buffer_id, })
  vim.api.nvim_open_win(buffer_id, true, window_opts)
end

return M

-- ----------------------------------- Write while keeping last changes position
-- vim.keymap.set('n', 'gs', function()
--   local start = vim.fn.getpos("'[")
--   local finish = vim.fn.getpos("']")

--   vim.cmd('silent! write')

--   vim.fn.setpos("'[", start)
--   vim.fn.setpos("']", finish)
-- end)

-- ----------------------------------- Treesitter text object hook

-- local ts = vim.treesitter
-- local api = vim.api

-- -- Function to get the node at cursor
-- local function get_node_at_cursor()
--   local bufnr = api.nvim_get_current_buf()
--   local row, col = unpack(api.nvim_win_get_cursor(0))
--   row = row - 1 -- API uses 0-based rows

--   local parser = ts.get_parser(bufnr)
--   if not parser then return end

--   local root = parser:parse()[1]:root()
--   return root:named_descendant_for_range(row, col, row, col)
-- end

-- -- Function to check if cursor is on a specific text object
-- local function is_cursor_on_text_object(object_type)
--   local node = get_node_at_cursor()
--   if not node then return false end

--   return node:type() == object_type
-- end

-- -- Function to print message when cursor is on specific text object
-- local function print_message_on_text_object(object_type, message)
--   if is_cursor_on_text_object(object_type) then
--     print(message)
--   end
-- end

-- -- Function to attach a mapping when cursor is on specific text object
-- local function attach_mapping_on_text_object(object_type, mode, lhs, rhs, opts)
--   if is_cursor_on_text_object(object_type) then
--     local buffer = api.nvim_get_current_buf()
--     opts = opts or { noremap = true, silent = true, buffer = buffer, }
--     api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
--   else
--     -- Remove the mapping if it exists and we're not on the text object
--     pcall(api.nvim_buf_del_keymap, api.nvim_get_current_buf(), mode, lhs)
--   end
-- end

-- -- Set up an autocommand to check cursor position
-- api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', }, {
--   pattern = '*',
--   callback = function()
--     -- Example: Print message when cursor is on a function declaration
--     print_message_on_text_object('function_declaration', 'Cursor is on a function declaration!')
--     attach_mapping_on_text_object(
--       'function_declaration',
--       'n',
--       '<leader>f',
--       ":echo 'Function action'<CR>",
--       { desc = 'Perform action on function', }
--     )

--     -- You can add more checks for different text objects here
--     -- For example:
--     -- print_message_on_text_object("if_statement", "Cursor is on an if statement!")
--     -- print_message_on_text_object("variable_declaration", "Cursor is on a variable declaration!")
--   end,
-- })
