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
function _G._appendCharEndLine()
  return appendSingleChar(colAfterLine)
end

function _G._appendCharStartLine()
  return appendSingleChar(colBeforeLine)
end

function _G._appendCharBeforeCursor()
  return appendSingleChar(colBeforeCursor)
end

function _G._appendCharAfterCursor()
  return appendSingleChar(colAfterCursor)
end

-------------------- Dot repeat
local function dot_repeat_wrapper(name)
  vim.go.operatorfunc = 'v:lua.' .. name
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

-- local function getRegister(command)
--   local register = {}
--   register.name = command:match('^"(.)') or vim.v.register
--   register.contents = vim.fn.getreg(register.name)
--   register.type = vim.fn.getregtype(register.name)
--   return register
-- end

-- local function putLinewise(command)
--   local register = getRegister(command)
--   local str = register.contents

--   vim.fn.setreg(register.name, str, "V")                                        -- Set register linewise
--   vim.fn.execute("normal! " .. vim.v.count1 .. '"' .. register.name .. command) -- Put register
--   vim.fn.setreg(register.name, register.contents, register.type)                -- Restore register
-- end

-- local function putCharwise(command)
--   local register = getRegister(command)
--   local str

  -- -- If register type is blockwise-visual then put as usual
  -- if register.type ~= "V" and register.type ~= "v" then
  --   vim.fn.execute("normal! " .. vim.v.count1 .. '"' .. register.name .. command)
  --   return
  -- end

  -- -- If register type is linewise then remove spaces at both extremities
  -- if register.type == "V" then
  --   str = register.contents:gsub("^%s*(.-)%s*$", "%1")
  -- else
  --   str = register.contents
  -- end

--   vim.fn.setreg(register.name, str, "v")                                        -- Set register charwise
--   vim.fn.execute("normal! " .. vim.v.count1 .. '"' .. register.name .. command) -- Put register
--   vim.fn.setreg(register.name, register.contents, register.type)                -- Restore register
-- end

-- function M.putCharwise(command)
--   return function() putCharwise(command) end
-- end

-- function M.putLinewise(command)
--   return function() putLinewise(command) end
-- end

return M
