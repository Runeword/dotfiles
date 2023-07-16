local vim = vim
local remap = { remap = true, }

vim.keymap.set('x', '<C-n>', ':Norm ')
vim.keymap.set('n', '<Leader>ch', '<cmd>silent !google-chrome-stable %:p<CR>')

-- Terminal
vim.keymap.set('n', '<Leader>t', '<cmd>te<CR>')
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Unmap
vim.keymap.set('n', 'rr', 'r')
vim.keymap.set('n', 'r', '<Nop>')
vim.keymap.set('n', '<Enter>', '<Nop>')
vim.keymap.set('n', '<C-n>', '<Nop>')
vim.keymap.set('n', '<C-p>', '<Nop>')
vim.keymap.set('', 'Q', '<Nop>')
vim.keymap.set('', 'q', '<Nop>')

-- Save
vim.keymap.set('n', '<C-s>', '<cmd>silent write<CR>')
vim.keymap.set('i', '<C-s>', '<Esc>`^<cmd>silent write<CR>')
vim.keymap.set('x', '<C-s>', '<Esc><cmd>silent write<CR>')
vim.keymap.set('n', '<Leader>s', '<cmd>silent write<CR>')
vim.keymap.set('i', '<Leader>s', '<Esc>`^<cmd>silent write<CR>')
vim.keymap.set('x', '<Leader>s', '<Esc><cmd>silent write<CR>')

-- Edit
vim.keymap.set('i', 'ù', '<Esc>`^u')
vim.keymap.set('i', '<C-BS>', '<Esc>cvb')
-- vim.keymap.set('n', '<BS>', '"_ciw')

local input_cache = nil
vim.api.nvim_set_hl(0, 'BoosterAppendChar', { fg = 'white', bg = 'none', })
local namespace = vim.api.nvim_create_namespace('booster')

local function setVirtualText(row, col)
end

-------------------- Main function
local function appendSingleChar(row, col)
  if input_cache then
    -- Set character
    vim.api.nvim_buf_set_text(0, row, col, row, col,
      { string.rep(input_cache, vim.v.count1), })
  end
end

-------------------- Position
local function getLineStr(row)
  return vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
end

-- local function endOfLinePos()
--   local row = vim.api.nvim_win_get_cursor(0)[1]
--   return
--       row - 1,
--       string.len(getLineStr(row))
-- end

-- local function startOfLinePos()
--   local row = vim.api.nvim_win_get_cursor(0)[1]
--   return
--       row - 1,
--       (string.find(getLineStr(row), '(%S)') or 1) - 1
-- end

local function startOfLineCol(row)
  return (string.find(getLineStr(row), '(%S)') or 1) - 1
end

local function endOfLineCol(row)
  return string.len(getLineStr(row))
end

local function beforePos()
  local pos = vim.api.nvim_win_get_cursor(0)
  return
      pos[1] - 1,
      pos[2]
end

local function afterPos()
  local pos = vim.api.nvim_win_get_cursor(0)
  return
      pos[1] - 1,
      pos[2] + 1
end

local function main(acol)
  local isVisual = string.match(vim.api.nvim_get_mode().mode, '[vV]')
  local startPos = vim.api.nvim_buf_get_mark(0, isVisual and '<' or '[')
  local endPos = vim.api.nvim_buf_get_mark(0, isVisual and '>' or ']')
  local lines = vim.api.nvim_buf_get_lines(0, startPos[1] - 1, endPos[1],
    false)

  if not input_cache then
    local extmarks = {}

    -- Set virtual text
    for i, str in ipairs(lines) do
      table.insert(extmarks, vim.api.nvim_buf_set_extmark(
        0, namespace, startPos[1] - 2 + i,
        acol(startPos[1] - 1 + i),
        {
          virt_text = { { '_', 'BoosterAppendChar', }, },
          virt_text_pos = 'inline',
          priority = 200,
        }
      ))
    end

    vim.api.nvim_command('redraw')

    -- Prompt for character
    local ok, charstr = pcall(vim.fn.getcharstr)
    local exitKeys = { [''] = true, }

    -- Cache character if prompt not aborted
    if ok and not exitKeys[charstr] then
      input_cache = charstr
    end

    -- Clear virtual text
    for i, extmark in ipairs(extmarks) do
      vim.api.nvim_buf_del_extmark(0, namespace, extmark)
    end
  end

  if not input_cache then return end

  -- Set character
  for i, str in ipairs(lines) do
    local row = startPos[1] - 2 + i
    local col = acol(startPos[1] - 1 + i)
    vim.api.nvim_buf_set_text(0, row, col, row, col,
      { string.rep(input_cache, vim.v.count1), })
  end
end

-------------------- Initialization
function _G._appendCharEndLine()
  return main(endOfLineCol)
end

function _G._appendCharStartLine()
  return main(startOfLineCol)
end

function _G._appendCharBefore()
  return appendSingleChar(beforePos())
end

function _G._appendCharAfter()
  return appendSingleChar(afterPos())
end

-------------------- Dot repeat
local function dot_repeat_wrapper(name)
  vim.go.operatorfunc = 'v:lua.' .. name

  local isVisual = string.match(vim.api.nvim_get_mode().mode, '[vV]')
  if isVisual then
    vim.api.nvim_feedkeys('g@', 'n', false)
  else
    vim.api.nvim_feedkeys('g@l', 'n', false)
  end
end

local function appendCharEndLine()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharEndLine')
end

local function appendCharStartLine()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharStartLine')
end

local function appendCharBefore()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharBefore')
end

local function appendCharAfter()
  input_cache = nil
  return dot_repeat_wrapper('_appendCharAfter')
end

-------------------- Mappings
vim.keymap.set({ 'x', 'n', }, 'ga', appendCharEndLine, { expr = true, })
vim.keymap.set({ 'x', 'n', }, 'gi', appendCharStartLine, { expr = true, })
vim.keymap.set('n', 'ra', appendCharAfter, { expr = true, })
vim.keymap.set('n', 'ri', appendCharBefore, { expr = true, })

function _G._appendNewlineBelow()
  local newLines = {}; for i = 1, vim.v.count1 do newLines[i] = '' end
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, newLines)
end

function _G._appendNewlineAbove()
  local newLines = {}; for i = 1, vim.v.count1 do newLines[i] = '' end
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, newLines)
end

local function appendNewlineAbove()
  dot_repeat_wrapper('_appendNewlineAbove')
end

local function appendNewlineBelow()
  dot_repeat_wrapper('_appendNewlineBelow')
end

-- vim.keymap.set('n', 'go', appendNewlineBelow)
-- vim.keymap.set('n', 'gO', appendNewlineAbove)

vim.keymap.set('n', 'go', appendNewlineBelow, { expr = true, })
vim.keymap.set('n', 'gO', appendNewlineAbove, { expr = true, })

-- vim.api.nvim_buf_add_highlight(0, namespace, 'Visual', row, col, col + 1)
-- vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
-- vim.api.nvim_command('redraw')
-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>w', true, false, true), 'n', false)

-- Text objects
vim.keymap.set({ 'x', 'o', }, 'a<Leader>', 'ap')
vim.keymap.set({ 'x', 'o', }, 'i<Leader>', 'ip')
vim.keymap.set({ 'o', }, '<Leader>', 'ip')

vim.keymap.set({ 'x', 'o', }, 'q', 'iq', remap)
vim.keymap.set({ 'x', 'o', }, 'nq', 'inq', remap)
vim.keymap.set({ 'x', 'o', }, 'oq', 'ioq', remap)

vim.keymap.set({ 'x', 'o', }, 'a', 'ia', remap)
vim.keymap.set({ 'x', 'o', }, 'na', 'ina', remap)
vim.keymap.set({ 'x', 'o', }, 'oa', 'ioa', remap)

vim.keymap.set({ 'o', }, 'w', 'iw', remap)
vim.keymap.set({ 'o', }, 'W', 'iW', remap)

-- vim.keymap.set({ 'x', 'o' }, "n}", "an{", remap)
-- vim.keymap.set({ 'x', 'o' }, "o}", "ao{", remap)
-- vim.keymap.set({ 'x', 'o' }, "n{", "in}", remap)
-- vim.keymap.set({ 'x', 'o' }, "o{", "io}", remap)
-- vim.keymap.set({ 'x', 'o' }, '}', 'a{', remap)
-- vim.keymap.set({ 'x', 'o' }, '{', 'i{', remap)
-- vim.keymap.set({ 'x', 'o' }, "n)", "an)", remap)
-- vim.keymap.set({ 'x', 'o' }, "o)", "ao)", remap)
-- vim.keymap.set({ 'x', 'o' }, "n(", "in)", remap)
-- vim.keymap.set({ 'x', 'o' }, "o(", "io)", remap)
-- vim.keymap.set({ 'x', 'o' }, ')', 'a)', remap)
-- vim.keymap.set({ 'x', 'o' }, '(', 'i)', remap)
-- vim.keymap.set({ 'x', 'o' }, "n]", "an]", remap)
-- vim.keymap.set({ 'x', 'o' }, "o]", "ao]", remap)
-- vim.keymap.set({ 'x', 'o' }, "n[", "in]", remap)
-- vim.keymap.set({ 'x', 'o' }, "o[", "io]", remap)
-- vim.keymap.set({ 'x', 'o' }, ']', 'a]', remap)
-- vim.keymap.set({ 'x', 'o' }, '[', 'i]', remap)

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
vim.keymap.set('x', 'p', '"_dP')
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
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', '0', 'g0')
vim.keymap.set('n', '$', function()
  vim.fn.execute('normal! g$')
  vim.o.ve = ''
  vim.o.ve = 'all'
end)
vim.keymap.set('n', '^', 'g^')
vim.keymap.set('n', '&', 'g^')
vim.keymap.set({ 'n', 'x', }, '(', function() vim.fn.search('(') end)
vim.keymap.set({ 'n', 'x', }, ')', function() vim.fn.search(')') end)
-- vim.keymap.set({ 'n', 'x' }, ')', function() vim.fn.search('(', 'b') end)
vim.keymap.set({ 'n', 'x', }, '[', function() vim.fn.search('[') end)
vim.keymap.set({ 'n', 'x', }, ']', function() vim.fn.search(']') end)
-- vim.keymap.set({ 'n', 'x' }, ']', function() vim.fn.search('[', 'b') end)
vim.keymap.set({ 'n', 'x', }, '{', function() vim.fn.search('{') end)
vim.keymap.set({ 'n', 'x', }, '}', function() vim.fn.search('}') end)
-- vim.keymap.set({ 'n', 'x' }, '}', function() vim.fn.search('{', 'b') end)

-- Buffers
-- vim.keymap.set('n', '<Leader>w', '<C-w>', { noremap = true, })
vim.keymap.set('n', '<Leader>q', '<cmd>q!<CR>')
vim.keymap.set('n', 'qq', '<cmd>bwipeout!<CR>', { silent = true, })
-- vim.keymap.set('n', '<C-t>', '<cmd>enew<CR>', { silent = true, })
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, })
-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, })

-------------------- folke/lazy.nvim
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
