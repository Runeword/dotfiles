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

local function appendSingleChar(get_col)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = get_col(vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1],
    false)[1])

  -- Set virtual text
  local namespace = vim.api.nvim_create_namespace('booster')
  local extmark = vim.api.nvim_buf_set_extmark(0, namespace, row, col, {
    virt_text = { { '_', 'Normal', }, },
    virt_text_pos = 'inline',
    priority = 200,
  })
  vim.api.nvim_command('redraw')

  -- Set character
  local ok, charstr = pcall(vim.fn.getcharstr)
  local exitKeys = { [''] = true, }
  if ok and not exitKeys[charstr] then
    vim.api.nvim_buf_set_text(0, row, col, row, col, { charstr, })
  end

  -- Clear virtual text
  vim.api.nvim_buf_del_extmark(0, namespace, extmark)
end

local function appendCharEndLine()
  return appendSingleChar(function(line) return string.len(line) end)
end

local function appendCharStartLine()
  return appendSingleChar(function(line) return string.find(line, '(%S)') - 1 end)
end

vim.keymap.set({ 'n', }, 'ga', appendCharEndLine)
vim.keymap.set({ 'n', }, 'gi', appendCharStartLine)

-- local function appendSingleChar(get_col)
--   local cursor = vim.api.nvim_win_get_cursor(0)
--   local row = cursor[1] - 1
--   local col = get_col(vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1],
--     false)[1])
--
--   -- Set virtual text
--   local namespace = vim.api.nvim_create_namespace('booster')
--   local extmark = vim.api.nvim_buf_set_extmark(0, namespace, row, col, {
--     virt_text = { { '_', 'Normal', }, },
--     virt_text_pos = 'inline',
--     priority = 200,
--   })
--   vim.api.nvim_command('redraw')
--
--   -- Set character
--   local ok, charstr = pcall(vim.fn.getcharstr)
--   local exitKeys = { [''] = true, }
--   if ok and not exitKeys[charstr] then
--     vim.api.nvim_buf_set_text(0, row, col, row, col, { charstr, })
--   end
--
--   -- Clear virtual text
--   vim.api.nvim_buf_del_extmark(0, namespace, extmark)
-- end
--
-- _G.my_count = 0
--
-- function _G.appendCharEndLine()
--   my_count = my_count + 1
--   print('Count: ' .. my_count)
--   return appendSingleChar(function(line) return string.len(line) end)
-- end
--
-- local function appendCharStartLine()
--   return appendSingleChar(function(line) return string.find(line, '(%S)') - 1 end)
-- end
--
-- vim.keymap.set({ 'n', }, 'ga', appendCharEndLine)
-- vim.keymap.set({ 'n', }, 'gi', appendCharStartLine)
--
-- _G.main_func = function()
--   my_count = 0
--   vim.go.operatorfunc = 'v:lua.appendCharEndLine'
--   vim.api.nvim_feedkeys('g@l', 'n', false)
--   -- return "g@l"
-- end
--
-- _G.callback = function()
--   my_count = my_count + 1
--   print('Count: ' .. my_count)
-- end
--
-- vim.keymap.set('n', 'gt', main_func)

-- vim.api.nvim_buf_add_highlight(0, namespace, 'Visual', row, col, col + 1)
-- vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
-- vim.api.nvim_command('redraw')

-- Text objects
vim.keymap.set({ 'x', 'o', }, 'a<Leader>', 'ap')
vim.keymap.set({ 'x', 'o', }, 'i<Leader>', 'ip')
vim.keymap.set({ 'o', }, '<Leader>', 'ip')

vim.keymap.set({ 'x', 'o', }, 'q', 'iq', remap)
vim.keymap.set({ 'x', 'o', }, 'nq', 'inq', remap)
vim.keymap.set({ 'x', 'o', }, 'oq', 'ipq', remap)

vim.keymap.set({ 'x', 'o', }, 'a', 'ia', remap)
vim.keymap.set({ 'x', 'o', }, 'na', 'ina', remap)
vim.keymap.set({ 'x', 'o', }, 'oa', 'ipa', remap)

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
vim.keymap.set('n', ')', function() vim.fn.search('(', 'b') end)
vim.keymap.set('n', '[', function() vim.fn.search('[') end)
vim.keymap.set('n', ']', function() vim.fn.search('[', 'b') end)
vim.keymap.set('n', '{', function() vim.fn.search('{') end)
vim.keymap.set('n', '}', function() vim.fn.search('{', 'b') end)

-- Buffers
vim.keymap.set('n', '<Leader>w', '<C-w>', { noremap = true, })
vim.keymap.set('n', '<C-t>', '<cmd>enew<CR>', { silent = true, })
vim.keymap.set('n', '<C-w>', '<cmd>bwipeout!<CR>', { silent = true, })
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, })
-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, })

vim.keymap.set('n', '<C-q>', '<cmd>q!<CR>')

-------------------- folke/lazy.nvim
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
