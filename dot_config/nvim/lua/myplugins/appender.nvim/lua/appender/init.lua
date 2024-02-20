local vim = vim

local M = {}

vim.api.nvim_set_hl(0, 'BoosterAppendChar', { fg = 'white', bg = 'none', })
local input_cache = nil
local namespace = vim.api.nvim_create_namespace('booster')

local function getLineStr(row)
  return vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
end

-------------------- Column position to insert the new character
local function colBeforeLine(row)
  return (string.find(getLineStr(row), '(%S)') or 1) - 1
end

local function colAfterLine(row)
  return string.len(getLineStr(row))
end

local function colBeforeCursor()
  return vim.fn.virtcol('.') - 1
end

local function colAfterCursor()
  return vim.fn.virtcol('.')
end

-------------------- Main function
local function appendSingleChar(getColumn)
  local isVisual = string.match(vim.api.nvim_get_mode().mode, '[vV\22]')
  local startRow = vim.api.nvim_buf_get_mark(0, isVisual and '<' or '[')[1]
  local endRow = vim.api.nvim_buf_get_mark(0, isVisual and '>' or ']')[1]
  local lines = vim.api.nvim_buf_get_lines(0, startRow - 1, endRow, false)

  -- If no character has been cached yet then we need to prompt the user for one
  if not input_cache then
    local extmarks = {}

    -- Set virtual text when the cursor column is inside a non empty string
    for i, str in ipairs(lines) do
      local col = getColumn(startRow - 1 + i)
      local row = startRow - 2 + i
      local len = string.len(str)

      if len ~= 0 and len >= col then
        table.insert(
          extmarks,
          vim.api.nvim_buf_set_extmark(0, namespace, row, col,
            {
              virt_text = { { '_', 'BoosterAppendChar', }, },
              virt_text_pos = 'inline',
              priority = 200,
            }
          ))
      end
    end

    -- Quit if no extmarks have been set
    if #extmarks == 0 then return end

    vim.api.nvim_command('redraw')

    -- Prompt for one character
    local ok, charstr = pcall(vim.fn.getcharstr)

    -- Clear virtual text
    for _, extmark in ipairs(extmarks) do
      vim.api.nvim_buf_del_extmark(0, namespace, extmark)
    end

    -- Quit if prompt is aborted
    local exitKeys = { [''] = true, }
    if not ok or exitKeys[charstr] then return end

    -- Cache character input
    input_cache = charstr
  end

  -- Set character when the cursor column is inside a non empty string
  for i, str in ipairs(lines) do
    local col = getColumn(startRow - 1 + i)
    local row = startRow - 2 + i
    local len = string.len(str)

    if len ~= 0 and len >= col then
      vim.api.nvim_buf_set_text(0, row, col, row, col,
        { string.rep(input_cache, vim.v.count1), })
    end
  end
end

-------------------- Initialization
local appender = {}

function appender._appendCharEndLine()
  return appendSingleChar(colAfterLine)
end

function appender._appendCharStartLine()
  return appendSingleChar(colBeforeLine)
end

function appender._appendCharBeforeCursor()
  return appendSingleChar(colBeforeCursor)
end

function appender._appendCharAfterCursor()
  return appendSingleChar(colAfterCursor)
end

-- Export functions
_G.appender = appender

-------------------- Dot repeat
local function dot_repeat_wrapper(name)
  vim.go.operatorfunc = 'v:lua.appender.' .. name
  local isVisual = string.match(vim.api.nvim_get_mode().mode, '[vV\22]')
  vim.api.nvim_feedkeys(isVisual and 'g@' or 'g@l', 'n', false)
end

function M.appendCharEndLine()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharEndLine')
end

function M.appendCharStartLine()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharStartLine')
end

function M.appendCharBeforeCursor()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharBeforeCursor')
end

function M.appendCharAfterCursor()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharAfterCursor')
end


-------------------- Append newline
local function appendNewLine(rowOffset)
  local newLines = {}; for i = 1, vim.v.count1 do newLines[i] = '' end
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row + rowOffset, row + rowOffset, false, newLines)
end

function appender._appendNewlineBelow() appendNewLine(0) end

function appender._appendNewlineAbove() appendNewLine(-1) end

function M.appendNewlineAbove() dot_repeat_wrapper('_appendNewlineAbove') end
function M.appendNewlineBelow() dot_repeat_wrapper('_appendNewlineBelow') end

return M

-- local cursor = vim.api.nvim_win_get_cursor(0)
-- local node = vim.treesitter.get_node()
-- local start_row, start_col, end_row, end_col = node:range()
-- -- get node type
--     print("Node range - Start: " .. start_row .. ":" .. start_col .. " End: " .. end_row .. ":" .. end_col)
--     local bufnr = vim.api.nvim_get_current_buf()
--     local highlight_group = "search"  -- Replace with your highlight group
--        vim.api.nvim_buf_add_highlight(bufnr, -1, highlight_group, start_row, start_col, end_col)
