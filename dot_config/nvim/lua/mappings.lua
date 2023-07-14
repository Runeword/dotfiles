local vim = vim
local remap = { remap = true, }

vim.keymap.set('x', '<C-n>', ':Norm ')
vim.keymap.set('n', '<Leader>ch', '<cmd>silent !google-chrome-stable %:p<CR>')

-- Terminal
vim.keymap.set('n', '<Leader>t', '<cmd>te<CR>')
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Unmap
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

local function posEndOfLine()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return cursor[1] - 1,
      string.len(
        vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1]
      )
end

local function posStartOfLine()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return cursor[1] - 1,
      string.find(
        vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1], '(%S)'
      ) - 1
end

local function appendSingleChar(row, col)
  -- Set virtual text
  local namespace = vim.api.nvim_create_namespace('booster')
  local extmark = vim.api.nvim_buf_set_extmark(0, namespace, row, col, {
    virt_text = { { '_', 'Normal', }, },
    virt_text_pos = 'inline',
    priority = 200,
  })
  vim.api.nvim_command('redraw')

  -- Set character
  vim.print(input_cache)
  if input_cache then
    vim.api.nvim_buf_set_text(0, row, col, row, col, { input_cache, })
  else
    local ok, charstr = pcall(vim.fn.getcharstr)
    input_cache = charstr
    local exitKeys = { [''] = true, }
    if ok and not exitKeys[charstr] then
      vim.api.nvim_buf_set_text(0, row, col, row, col, { charstr, })
    end
  end

  -- Clear virtual text
  vim.api.nvim_buf_del_extmark(0, namespace, extmark)
end

-- local my_count = 0

function _G._appendCharEndLine()
  -- my_count = my_count + 1
  -- print('Count: ' .. my_count)
  return appendSingleChar(posEndOfLine())
end

function _G._appendCharStartLine()
  return appendSingleChar(posStartOfLine())
end

local function dot_repeat_wrapper(name)
  input_cache = nil
  -- my_count = 0
  vim.go.operatorfunc = 'v:lua.' .. name
  vim.api.nvim_feedkeys('g@l', 'n', false)
end

local function appendCharEndLine() return dot_repeat_wrapper('_appendCharEndLine') end
local function appendCharStartLine() return dot_repeat_wrapper('_appendCharStartLine') end

vim.keymap.set('n', 'ga', appendCharEndLine)
vim.keymap.set({ 'n', }, 'gi', appendCharStartLine)

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
vim.keymap.set('n', '(', function() vim.fn.search('(') end)
vim.keymap.set('n', ')', function() vim.fn.search(')') end)
-- vim.keymap.set('n', ')', function() vim.fn.search('(', 'b') end)
vim.keymap.set('n', '[', function() vim.fn.search('[') end)
vim.keymap.set('n', ']', function() vim.fn.search(']') end)
-- vim.keymap.set('n', ']', function() vim.fn.search('[', 'b') end)
vim.keymap.set('n', '{', function() vim.fn.search('{') end)
vim.keymap.set('n', '}', function() vim.fn.search('}') end)
-- vim.keymap.set('n', '}', function() vim.fn.search('{', 'b') end)

-- Buffers
vim.keymap.set('n', '<Leader>w', '<C-w>', { noremap = true, })
vim.keymap.set('n', '<C-t>', '<cmd>enew<CR>', { silent = true, })
vim.keymap.set('n', '<C-w>', '<cmd>bwipeout!<CR>', { silent = true, })
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, })
-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, })

vim.keymap.set('n', '<C-q>', '<cmd>q!<CR>')

-------------------- folke/lazy.nvim
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
