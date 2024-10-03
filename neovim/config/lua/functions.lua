local vim = vim

local M = {}

-------------------- Word

local function isEndOfWord()
  local pos = vim.fn.getpos('.')
  vim.print(pos)
  vim.fn.execute("normal! gee")
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
  vim.fn.execute("normal! gew")
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
  return (vim.o.virtualedit ~= '') and (vim.fn.col(".") <= string.find(vim.fn.getline(vim.fn.line(".")), "(%S)") - 1)
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

return M
