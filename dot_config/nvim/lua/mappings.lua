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
vim.cmd([[
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap <A-a> :<C-U>exec "normal A".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap <A-i> :<C-U>exec "normal I".RepeatChar(nr2char(getchar()), v:count1)<CR>
]])

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
