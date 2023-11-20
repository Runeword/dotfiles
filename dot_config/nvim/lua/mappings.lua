local vim = vim
local remap = { remap = true, }

vim.keymap.set('x', '<C-n>', ':Norm ')
vim.keymap.set('n', '<Leader>g', '<cmd>silent !google-chrome-stable %:p<CR>')
vim.keymap.set('n', 'g<Space>', '<cmd>silent %s/\\s\\+$//e<CR>')
vim.keymap.set({ 'x', 'n', }, '<Space>', '<Enter>', remap)

vim.keymap.set('n', '<Leader>ti', '<cmd>Inspect<CR>')
vim.keymap.set('n', '<Leader>tt', '<cmd>InspectTree<CR>')
vim.keymap.set('n', '<Leader>tq', '<cmd>PreviewQuery<CR>')

function OpenNextDiagnosticInSplit()
  local next_diagnostic = vim.diagnostic.get_next()

  if not next_diagnostic then return end

  -- vim.diagnostic.goto_next({ float = false, })
  vim.api.nvim_win_set_cursor(0, {next_diagnostic.lnum + 1, next_diagnostic.col})

  local current_window = vim.api.nvim_get_current_win()
  local current_buffer = vim.api.nvim_get_current_buf()

  -- vim.diagnostic.goto_next({win_id = current_window })

  local buffer_id = vim.fn.bufnr('diagnostic_message')
  if buffer_id == -1 then
    -- Create a new buffer
    buffer_id = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buffer_id, 'diagnostic_message')

    -- Open a new split window
    vim.api.nvim_command('belowright 5 split')

    -- Set the new buffer in the split window
    vim.api.nvim_win_set_buf(0, buffer_id)
    vim.api.nvim_buf_set_option(buffer_id, 'number', false)
    vim.api.nvim_buf_set_option(buffer_id, 'filetype', 'diagmsg')
  end

  -- Set the diagnostic message in the new buffer
  local diagnostic_line = vim.api.nvim_buf_get_lines(current_buffer, next_diagnostic.lnum, next_diagnostic.lnum + 1, false)
  -- print(vim.inspect(next_diagnostic))
  vim.api.nvim_buf_set_lines(buffer_id, 0, -1, false, { diagnostic_line[1], next_diagnostic.source .. ' ' .. next_diagnostic.code, next_diagnostic.message, })
  vim.api.nvim_set_current_win(current_window)
end

vim.keymap.set('n', '<PageUp>', OpenNextDiagnosticInSplit, { noremap = true, silent = true, })
vim.keymap.set('n', '<PageDown>', OpenNextDiagnosticInSplit, { noremap = true, silent = true, })

-- vim.keymap.set('n', '<PageUp>', vim.diagnostic.goto_prev, { buffer = buffer, })
-- vim.keymap.set('n', '<PageDown>', vim.diagnostic.goto_next, { buffer = buffer, })

vim.keymap.set('n', '<C-i>', '<C-i>', { silent = true, })
-- vim.keymap.set('n', '<PageUp>', '<C-i>')
-- vim.keymap.set('n', '<PageDown>', '<C-o>')

vim.keymap.set('n', 'gs', function()
  local view = vim.fn.winsaveview()
  vim.o.undoreload = 0
  vim.cmd('edit')
  vim.fn.winrestview(view)
end, { silent = true, })

vim.keymap.set('n', 'i', function()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true, })

local isFolded = false
local function toggleFold()
  if not isFolded then
    vim.api.nvim_feedkeys('zR', 'n', false)
    isFolded = true
  else
    vim.api.nvim_feedkeys('zM', 'n', false)
    isFolded = false
  end
end

vim.keymap.set('n', 'g<Enter>', toggleFold)

-- vim.keymap.set('n', '<Leader>t', '<cmd>te<CR>')
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
-- vim.keymap.set('n', '<Esc>', '<Esc>g^')
vim.keymap.set('n', '<Esc>',
function()
  local buffer_id = vim.fn.bufnr('diagnostic_message')
  if buffer_id ~= -1 then vim.api.nvim_buf_delete(buffer_id, { force = true, unload = false, }) end
vim.fn.execute("normal! \\<Esc>g^")
end
)


-- Unmap
-- vim.keymap.set('n', '<Enter>', '<Nop>')
vim.keymap.set('n', '<C-n>', '<Nop>')
vim.keymap.set('n', '<C-p>', '<Nop>')
vim.keymap.set('', 'Q', '<Nop>')
vim.keymap.set('', 'q', '<Nop>')

-- Save
-- vim.keymap.set('n', '<C-s>',     '<cmd>silent write<CR>')
-- vim.keymap.set('i', '<C-s>',     '<Esc>`^<cmd>silent write<CR>')
-- vim.keymap.set('x', '<C-s>',     '<Esc><cmd>silent write<CR>')
vim.keymap.set('n', '<Leader>s', '<cmd>silent write<CR>')
vim.keymap.set('x', '<Leader>s', '<Esc><cmd>silent write<CR>')

-- Edit
-- vim.keymap.set('i', 'ù',     '<Esc>`^u')
vim.keymap.set('i', '<C-BS>', '<Esc>cvb')
vim.keymap.set('n', 'g<Tab>', 'za')
vim.keymap.set('n', 'U', '<cmd>u0<CR>')
vim.keymap.set('n', 'R', "<cmd>exec 'undo' undotree()['seq_last']<CR>")

-- vim.keymap.set('n', '<BS>', '"_ciw')

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

local function appendCharEndLine()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharEndLine')
end

local function appendCharStartLine()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharStartLine')
end

local function appendCharBeforeCursor()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharBeforeCursor')
end

local function appendCharAfterCursor()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharAfterCursor')
end

-------------------- Mappings
vim.keymap.set({ 'x', 'n', }, 'ga', appendCharEndLine, { expr = true, })
vim.keymap.set({ 'x', 'n', }, 'gi', appendCharStartLine, { expr = true, })

-- vim.keymap.set({ 'x', 'n', }, 'ra', appendCharAfterCursor,  { expr = true, })
-- vim.keymap.set({ 'x', 'n', }, 'ri', appendCharBeforeCursor, { expr = true, })

-------------------- Append newline
local function appendNewLine(rowOffset)
  local newLines = {}; for i = 1, vim.v.count1 do newLines[i] = '' end
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row + rowOffset, row + rowOffset, false, newLines)
end

function _G._appendNewlineBelow() appendNewLine(0) end

function _G._appendNewlineAbove() appendNewLine(-1) end

local function appendNewlineAbove() dot_repeat_wrapper('_appendNewlineAbove') end
local function appendNewlineBelow() dot_repeat_wrapper('_appendNewlineBelow') end

vim.keymap.set({ 'n', }, 'go', appendNewlineBelow, { expr = true, })
vim.keymap.set({ 'n', }, 'gO', appendNewlineAbove, { expr = true, })

-- vim.api.nvim_buf_add_highlight(0, namespace, 'Visual', row, col, col + 1)
-- vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)

-- Text objects

vim.keymap.set({ 'x', 'o', }, 'a<Space>', 'ap')
vim.keymap.set({ 'x', 'o', }, 'i<Space>', 'ip')
vim.keymap.set({ 'o', }, '<Space>', 'ip')
vim.keymap.set({ 'o', }, '<Enter>', 'ip')

vim.keymap.set({ 'x', 'o', }, 'q', 'iq', remap)
vim.keymap.set({ 'x', 'o', }, 'nq', 'inq', remap)
vim.keymap.set({ 'x', 'o', }, 'oq', 'ioq', remap)

vim.keymap.set({ 'x', 'o', }, 'a', 'ia', remap)
vim.keymap.set({ 'x', 'o', }, 'na', 'ina', remap)
vim.keymap.set({ 'x', 'o', }, 'oa', 'ioa', remap)

vim.keymap.set({ 'o', }, 'w', 'iw', remap)
vim.keymap.set({ 'o', }, 'W', 'iW', remap)

-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:()', 'i(', remap)
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:))', 'a)', remap)
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:{)', 'i{', remap)
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:})', 'a}', remap)
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:[)', 'i[', remap)
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:])', 'a]', remap)
-- vim.fn['arpeggio#map']('ox', '', 0, '()', 'a)')
-- vim.fn['arpeggio#map']('ox', '', 0, '{}', 'a}')
-- vim.fn['arpeggio#map']('ox', '', 0, '[]', 'a]')

-- Operators
-- vim.keymap.set('x', 'p', '"_dP')
vim.keymap.set({ 'n', 'v', }, 'd', '"_d')
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set('n', 'dd', '"_dd^')
vim.keymap.set({ 'n', 'v', }, 'x', '"_x')
vim.keymap.set({ 'n', 'v', }, 'm', 'd')
vim.keymap.set('n', 'M', 'D')
vim.keymap.set('n', 'mm', 'dd^')

-- Readline
vim.keymap.set('i', '<C-a>', '<esc>I')
vim.keymap.set('i', '<C-e>', '<end>')
vim.keymap.set('i', '<C-k>', '<esc>ld$i')
vim.keymap.set('i', '<C-H>', '<C-w>')

-- Motions
vim.keymap.set({ 'x', 'n' }, '<C-j>', 'J')
vim.keymap.set({ 'x', 'n' }, 'k', 'gk')
vim.keymap.set({ 'x', 'n' }, 'j', 'gj')
vim.keymap.set({ 'x', 'n' }, 'J', '4jg^')
vim.keymap.set({ 'x', 'n' }, 'K', '4kg^')
-- vim.cmd([[
-- nnoremap J :<C-u>call search('^.\+')<CR>
-- nnoremap K :<C-u>call search('^.\+', 'b')<CR>
-- ]])

vim.keymap.set('n', '0', 'g0')
vim.keymap.set('n', '$', function()
  vim.fn.execute('normal! g$')
  vim.o.ve = ''
  vim.o.ve = 'all'
end)
vim.keymap.set('n', '^', 'g^')
vim.keymap.set('n', '&', 'g^')

-- vim.keymap.set({ 'n', 'x', }, '<Enter>', function() vim.fn.search('[([{]') end)
-- vim.keymap.set({ 'n', 'x', }, '<S-Enter>', function() vim.fn.search('[([{]', 'b') end)

-- Buffers
vim.keymap.set({ 'n', 'x', }, '<Leader>q', '<cmd>qa!<CR>')
vim.keymap.set('n', '<C-w>', '<cmd>silent bwipeout!<CR>')
vim.keymap.set('n', '<C-t>', '<cmd>silent enew<CR>')
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, })
-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, })

-------------------- folke/lazy.nvim
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
