local vim = vim

local M = {}

local namespace = vim.api.nvim_create_namespace('putter')
vim.api.nvim_set_hl(0, 'putter', { bg = '#00226b', default = true, })

local function highlightChange()
  local timer = vim.loop.new_timer()

  -- Get the region of the previously changed or yanked text
  local start = vim.api.nvim_buf_get_mark(0, '[')
  local finish = vim.api.nvim_buf_get_mark(0, ']')

  -- Highlight the region
  vim.highlight.range(0, namespace, 'putter',
    { start[1] - 1, start[2], },
    { finish[1] - 1, finish[2], },
    { inclusive = true, }
  )

  -- Clear highlight after 500ms
  timer:start(500, 0,
    vim.schedule_wrap(
      function() vim.api.nvim_buf_clear_namespace(0, namespace, start[1] - 1, finish[1]) end
    -- function() vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1) end
    )
  )
end

local function getRegister(command)
  local register = {}
  register.name = command:match('^"(.)') or vim.v.register
  register.contents = vim.fn.getreg(register.name)
  register.type = vim.fn.getregtype(register.name)
  return register
end

local function putLinewise(command)
  local register = getRegister(command)
  local str = register.contents

  vim.fn.setreg(register.name, str, 'V')                                        -- Set register linewise
  vim.fn.execute('normal! ' .. vim.v.count1 .. '"' .. register.name .. command) -- Put register
  vim.fn.setreg(register.name, register.contents, register.type)                -- Restore register
end

local function putCharwise(command)
  local register = getRegister(command)
  local str

  -- If register type is blockwise-visual then put as usual
  if register.type ~= 'V' and register.type ~= 'v' then
    vim.fn.execute('normal! ' .. vim.v.count1 .. '"' .. register.name .. command)
    return
  end

  -- If register type is linewise then remove spaces at both extremities
  if register.type == 'V' then
    str = register.contents:gsub('^%s*(.-)%s*$', '%1')
  else
    str = register.contents
  end

  vim.fn.setreg(register.name, str, 'v')                                        -- Set register charwise
  vim.fn.execute('normal! ' .. vim.v.count1 .. '"' .. register.name .. command) -- Put register
  vim.fn.setreg(register.name, register.contents, register.type)                -- Restore register
end

function M.putCharwiseAfter()
  putCharwise('p')
  highlightChange()
end

function M.putCharwiseBefore()
  putCharwise('P')
  highlightChange()
end

function M.putLinewiseAfter()
  putLinewise(']p`]')
  highlightChange()
end

function M.putLinewiseBefore()
  putLinewise(']P`]')
  highlightChange()
end

return M
