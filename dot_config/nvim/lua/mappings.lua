local vim = vim
local remap = { remap = true, }

vim.keymap.set('x', '<C-n>', ':Norm ')
vim.keymap.set('n', '<Leader>ch', '<cmd>silent !google-chrome-stable %:p<CR>')

-- Terminal
vim.keymap.set('n', '<Leader>t', '<cmd>te<CR>')
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Unmap
vim.keymap.set('n', 'gr', 'r')
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

-- Edit
vim.keymap.set('i', 'ù', '<Esc>`^u')
vim.keymap.set('i', '<C-BS>', '<Esc>cvb')
-- vim.keymap.set('n', '<BS>', '"_ciw')

-- vim.cmd([[
-- function! RepeatChar(char, count)
--   return repeat(a:char, a:count)
-- endfunction
-- nnoremap ga :<C-U>exec "normal A".RepeatChar(nr2char(getchar()), v:count1)<CR>
-- nnoremap gi :<C-U>exec "normal I".RepeatChar(nr2char(getchar()), v:count1)<CR>
-- ]])

local input_cache = nil
vim.api.nvim_set_hl(0, 'BoosterAppendChar', { fg = 'white', bg = 'none', })

-------------------- Main function
local function appendSingleChar(row, col)
  -- Set virtual text
  local namespace = vim.api.nvim_create_namespace('booster')
  local extmark = vim.api.nvim_buf_set_extmark(0, namespace, row, col, {
    virt_text = { { '_', 'BoosterAppendChar', }, },
    virt_text_pos = 'inline',
    priority = 200,
  })
  vim.api.nvim_command('redraw')

  -- Set character
  if input_cache then
    vim.api.nvim_buf_set_text(0, row, col, row, col,
      { string.rep(input_cache, vim.v.count1), })
  else
    local ok, charstr = pcall(vim.fn.getcharstr)
    input_cache = charstr
    local exitKeys = { [''] = true, }

    if ok and not exitKeys[charstr] then
      vim.api.nvim_buf_set_text(0, row, col, row, col,
        { string.rep(input_cache, vim.v.count1), })
    end
  end

  -- Clear virtual text
  vim.api.nvim_buf_del_extmark(0, namespace, extmark)
end

-------------------- Position
local function getLineStr(row)
  return vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
end

local function endOfLinePos()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  return
      row - 1,
      string.len(getLineStr(row))
end

local function startOfLinePos()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  return
      row - 1,
      (string.find(getLineStr(row), '(%S)') or 1) - 1
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

-------------------- Initialization
function _G._appendCharEndLine()
  return appendSingleChar(endOfLinePos())
end

function _G._appendCharStartLine()
  return appendSingleChar(startOfLinePos())
end

function _G._appendCharBefore()
  return appendSingleChar(beforePos())
end

function _G._appendCharAfter()
  return appendSingleChar(afterPos())
end

-------------------- Dot repeat
local function dot_repeat_wrapper(name)
  input_cache = nil
  vim.go.operatorfunc = 'v:lua.' .. name
  vim.api.nvim_feedkeys('g@l', 'n', false)
end

local function appendCharEndLine()
  return dot_repeat_wrapper('_appendCharEndLine')
end

local function appendCharStartLine()
  return dot_repeat_wrapper('_appendCharStartLine')
end

local function appendCharBefore()
  return dot_repeat_wrapper('_appendCharBefore')
end

local function appendCharAfter()
  return dot_repeat_wrapper('_appendCharAfter')
end

-------------------- Mappings
vim.keymap.set('n', 'ga', appendCharEndLine, { expr = true, })
vim.keymap.set('n', 'gi', appendCharStartLine, { expr = true, })
vim.keymap.set('n', 'ra', appendCharAfter, { expr = true, })
vim.keymap.set('n', 'ri', appendCharBefore, { expr = true, })

local function appendNewlineBelow()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, { '', })
end

local function appendNewlineAbove()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { '', })
end

vim.keymap.set('n', 'go', appendNewlineBelow)
vim.keymap.set('n', 'gO', appendNewlineAbove)

-- vim.keymap.set('n', 'go', appendNewlineBelow, { expr = true, })
-- vim.keymap.set('n', 'gO', appendNewlineAbove, { expr = true, })

-- vim.api.nvim_buf_add_highlight(0, namespace, 'Visual', row, col, col + 1)
-- vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
-- vim.api.nvim_command('redraw')

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
vim.keymap.set('n', '<Leader>w', '<C-w>', { noremap = true, })
vim.keymap.set('n', '<C-t>', '<cmd>enew<CR>', { silent = true, })
vim.keymap.set('n', '<C-w>', '<cmd>bwipeout!<CR>', { silent = true, })
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, })
-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, })

vim.keymap.set('n', '<C-q>', '<cmd>q!<CR>')

-------------------- folke/lazy.nvim
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
