local vim = vim
local map = vim.keymap.set
local silent = { silent = true, }
local expr = { expr = true, }
local remap = { remap = true, }

local function core()
  map('x', '<C-n>', ':Norm ')
  map('n', '<Leader>ch', '<cmd>silent !google-chrome-stable %:p<CR>')

  -- Help
  vim.cmd [[command! -nargs=1 -complete=help H h <args> | only]]
  vim.keymap.set('ca', 'h', [[getcmdtype() == ":" && getcmdline() == 'h' ? 'H' : 'h']], { expr = true, noremap = true })

  -- Terminal
  map('n', '<Leader>t', '<cmd>te<CR>')
  map('t', '<Esc>', [[<C-\><C-n>]])

  -- Unmap
  map('n', '<Enter>', '<Nop>')
  map('n', '<C-n>', '<Nop>')
  map('n', '<C-p>', '<Nop>')
  map('', 'Q', '<Nop>')
  map('', 'q', '<Nop>')

  -- Save
  map('n', '<C-s>', '<cmd>silent write<CR>')
  map('i', '<C-s>', '<Esc>`^<cmd>silent write<CR>')
  map('x', '<C-s>', '<Esc><cmd>silent write<CR>')

  -- Edit
  map('i', 'ù', '<Esc>`^u')
  map('i', '<C-BS>', '<Esc>cvb')
  -- map('n', '<BS>', '"_ciw')
  map('n', '<space>', 'a <Esc>r')

  -- Text objects
  map({ 'x', 'o', }, 'a<Leader>', 'ap')
  map({ 'x', 'o', }, 'i<Leader>', 'ip')
  map({ 'o', }, '<Leader>', 'ip')

  map({ 'x', 'o', }, 'q', 'iq', remap)
  map({ 'x', 'o', }, 'nq', 'inq', remap)
  map({ 'x', 'o', }, 'oq', 'ioq', remap)

  map({ 'x', 'o', }, 'a', 'ia', remap)
  map({ 'x', 'o', }, 'na', 'ina', remap)
  map({ 'x', 'o', }, 'oa', 'ioa', remap)

  -- map({ 'x', 'o' }, "n}", "an{", remap)
  -- map({ 'x', 'o' }, "o}", "ao{", remap)
  -- map({ 'x', 'o' }, "n{", "in}", remap)
  -- map({ 'x', 'o' }, "o{", "io}", remap)
  -- map({ 'x', 'o' }, '}', 'a{', remap)
  -- map({ 'x', 'o' }, '{', 'i{', remap)
  -- map({ 'x', 'o' }, "n)", "an)", remap)
  -- map({ 'x', 'o' }, "o)", "ao)", remap)
  -- map({ 'x', 'o' }, "n(", "in)", remap)
  -- map({ 'x', 'o' }, "o(", "io)", remap)
  -- map({ 'x', 'o' }, ')', 'a)', remap)
  -- map({ 'x', 'o' }, '(', 'i)', remap)
  -- map({ 'x', 'o' }, "n]", "an]", remap)
  -- map({ 'x', 'o' }, "o]", "ao]", remap)
  -- map({ 'x', 'o' }, "n[", "in]", remap)
  -- map({ 'x', 'o' }, "o[", "io]", remap)
  -- map({ 'x', 'o' }, ']', 'a]', remap)
  -- map({ 'x', 'o' }, '[', 'i]', remap)

  -- map({ 'x', 'o' }, '<Plug>(arpeggio-default:()', 'i(', remap)
  -- map({ 'x', 'o' }, '<Plug>(arpeggio-default:))', 'a)', remap)
  -- map({ 'x', 'o' }, '<Plug>(arpeggio-default:{)', 'i{', remap)
  -- map({ 'x', 'o' }, '<Plug>(arpeggio-default:})', 'a}', remap)
  -- map({ 'x', 'o' }, '<Plug>(arpeggio-default:[)', 'i[', remap)
  -- map({ 'x', 'o' }, '<Plug>(arpeggio-default:])', 'a]', remap)
  -- vim.fn['arpeggio#map']('ox', '', 0, '()', 'a)')
  -- vim.fn['arpeggio#map']('ox', '', 0, '{}', 'a}')
  -- vim.fn['arpeggio#map']('ox', '', 0, '[]', 'a]')

  -- Operators
  map('x', 'p', '"_dP')
  map({ 'n', 'v', }, 'd', '"_d')
  map('n', 'D', '"_D')
  map('n', 'dd', '"_dd^')
  map({ 'n', 'v', }, 'x', '"_x')
  map({ 'n', 'v', }, 'm', 'd')
  map('n', 'M', 'D')
  map('n', 'mm', 'dd^')

  -- Readline
  map('i', '<C-a>', '<esc>I')
  map('i', '<C-e>', '<end>')
  map('i', '<C-k>', '<esc>ld$i')
  map('i', '<C-H>', '<C-w>')

  -- Motions
  map('n', 'k', 'gk')
  map('n', 'j', 'gj')
  map('n', '0', 'g0')
  map('n', '$', function()
    vim.fn.execute('normal! g$')
    vim.o.ve = ''
    vim.o.ve = 'all'
  end)
  map('n', '^', 'g^')
  map('n', '&', 'g^')
  map('n', '(', function() vim.fn.search('(') end)
  map('n', ')', function() vim.fn.search('(', 'b') end)
  map('n', '[', function() vim.fn.search('[') end)
  map('n', ']', function() vim.fn.search('[', 'b') end)
  map('n', '{', function() vim.fn.search('{') end)
  map('n', '}', function() vim.fn.search('{', 'b') end)

  -- Buffers
  map('n', '<Leader>w', '<C-w>', { noremap = true, })
  map('n', '<C-t>', '<cmd>enew<CR>', silent)
  map('n', '<C-w>', '<cmd>bwipeout!<CR>', silent)
  -- map("n", "<Tab>", "<cmd>bnext<CR>", silent)
  -- map("n", "<S-Tab>", "<cmd>bprevious<CR>", silent)

  map('n', '<C-q>', '<cmd>q!<CR>')

  -------------------- folke/lazy.nvim
  map('n', '<leader>l', '<cmd>Lazy<CR>')
end

-------------------- nvim-telescope/telescope.nvim
local function telescope()
  -- map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", opts)
  -- map("n", "<leader>s", "<cmd>Telescope live_grep<cr>", opts)
  -- map("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)
end

-------------------- jonatan-branting/nvim-better-n
local function bettern()
  map('n', 'n', require('better-n').n, { nowait = true, })
  map('n', '<s-n>', require('better-n').shift_n, { nowait = true, })
end

-------------------- is0n/fm-nvim
local function fm()
  map('n', '<leader>n', '<cmd>Vifm<CR>')
end

-- -------------------- chaoren/vim-wordmotion
-- local function wordMotion()
-- local wordMotion = require('hydra')({ mode = { 'o', 'n', 'x' }, config = { hint = false, color = 'pink' }, heads = {
--   { 'w', '<Plug>WordMotion_w' },
--   { 'b', '<Plug>WordMotion_b' },
--   { 'e', '<Plug>WordMotion_e' },
--   { 'iw', '<Plug>WordMotion_iw' },
--   { 'aw', '<Plug>WordMotion_aw' },
--   { 'ge', '<Plug>WordMotion_ge' },
--   { 'q', nil, { exit = true } },
--   { '<Esc>', nil, { exit = true } },
--   { '<C-s>', nil, { exit = true } }
-- } })
-- map({ 'n', 'x' }, 'gw', function() wordMotion:activate() end)
-- end

return {
  core = core,
  telescope = telescope,
  fm = fm,
  bettern = bettern,
}
