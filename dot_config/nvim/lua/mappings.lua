local vim = vim
local map = vim.keymap.set
local silent = { silent = true, }
local expr = { expr = true, }
local remap = { remap = true, }

local function core()
  map('x', '<C-n>', ':Norm ')
  map('n', '<Leader>ch', '<cmd>silent !google-chrome-stable %:p<CR>')
  -- map("n", ";", ":", { noremap = true })
  -- map("n", ":", ";", { noremap = true })

  -- Help
  vim.cmd [[command! -nargs=1 -complete=help H h <args> | only]]
  vim.cmd [[cnoreabbrev <expr> h  getcmdtype() == ":" && getcmdline() == 'h' ? 'H' : 'h']]

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
  map('n', '<BS>', '"_ciw')
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

-- -------------------- williamboman/mason.nvim
-- local function mason()
--   map('n', '<Leader>m', '<cmd>Mason<Cr>')
-- end

-------------------- jonatan-branting/nvim-better-n
local function bettern()
  map('n', 'n', require('better-n').n, { nowait = true, })
  map('n', '<s-n>', require('better-n').shift_n, { nowait = true, })
end

-------------------- ggandor/leap.nvim
local function leap()
  map({ 'n', 'x', }, 's', '<Plug>(leap-forward)', remap)
  map({ 'n', 'x', }, 'S', '<Plug>(leap-backward)', remap)
end

-------------------- cshuaimin/ssr.nvim
local function ssr()
  map({ 'n', 'x', }, 't', function() require('ssr').open() end)
end

-------------------- woosaaahh/sj.nvim
local function sj()
  map({ 'n', 'o', 'x', }, 's', require('sj').run)
end

-------------------- is0n/fm-nvim
local function fm()
  map('n', '<leader>n', '<cmd>Vifm<CR>')
end

-------------------- neovim/nvim-lspconfig
local function lspconfig(buffer)
  map('n', 'gd', vim.lsp.buf.definition, { buffer = buffer, })
  map('n', 'gr', vim.lsp.buf.references, { buffer = buffer, })
  map('n', '<Leader>f', vim.lsp.buf.format, { buffer = buffer, })
  map('n', '<Leader>a', '<cmd>CodeActionMenu<Enter>', { buffer = buffer, })
  -- map('n', '<leader>r', function() lsp.buf.rename(vim.fn.input('New Name: ')) end, { buffer = buffer })
  -- map("n", '<ScrollWheelUp>', diagnostic.goto_prev, { buffer = buffer })
  -- map("n", '<ScrollWheelDown>', diagnostic.goto_next, { buffer = buffer })
  map('n', '<PageUp>', vim.diagnostic.goto_prev, { buffer = buffer, })
  map('n', '<PageDown>', vim.diagnostic.goto_next, { buffer = buffer, })
  -- map('n', '<Leader>l', diagnostic.setloclist, { noremap = true, silent = true })
  map('n', '<Leader>x', vim.diagnostic.setqflist,
    { noremap = true, silent = true, })
  -- lsp.buf.formatting_seq_sync(nil, 6000, { 'tsserver', 'html', 'cssls', 'vuels', 'eslint' })
  -- lsp.buf.formatting_seq_sync
end

-------------------- anuvyklack/hydra.nvim
local function hydra()
  require('hydra')({
    name = 'newline',
    mode = { 'n', 'x', },
    body = 'g',
    heads = {
      { 'o', '<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>', },
      { 'O', '<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>', },
    },
  })

  local scroll = require('hydra')({
    mode = { 'n', 'x', },
    config = {
      hint = false,
      on_enter = function() vim.o.scrolloff = 9999 end,
      on_exit = function() vim.o.scrolloff = 5 end,
    },
    heads = {
      { 'u', '5k', },
      { 'e', '5j', },
    },
  })

  map({ 'n', 'x', }, '<Leader>e',
    function()
      scroll:activate()
      vim.fn.execute('normal! 5j')
    end)
  map({ 'n', 'x', }, '<Leader>u',
    function()
      scroll:activate()
      vim.fn.execute('normal! 5k')
    end)

  local nextParagraphStart = function()
    vim.fn.search(
      [[\(^$\n\s*\zs\S\)\|\(\S\ze\n*\%$\)]], 'sW')
  end
  local nextParagraphEnd = function()
    vim.fn.search([[\(\n\s*\)\@<=\S\(.*\n^$\)\@=]],
      'sW')
  end
  local prevParagraphStart = function()
    vim.fn.search(
      [[\(^$\n\s*\zs\S\)\|\(^\%1l\s*\zs\S\)]], 'sWb')
  end
  local prevParagraphEnd = function()
    vim.fn.search([[\(\n\s*\)\@<=\S\(.*\n^$\)\@=]],
      'sWb')
  end

  local jumpParagraph = require('hydra')({
    mode = { 'n', 'x', },
    config = {
      hint = false,
      on_enter = function() vim.o.scrolloff = 9999 end,
      on_exit = function() vim.o.scrolloff = 5 end,
    },
    heads = {
      { '<Down>',   nextParagraphStart, },
      { '<Up>',     prevParagraphStart, },
      { '<C-Up>',   prevParagraphEnd, },
      { '<C-Down>', nextParagraphEnd, },
    },
  })

  map({ 'n', 'x', }, '<Down>',
    function()
      jumpParagraph:activate()
      nextParagraphStart()
    end)
  map({ 'n', 'x', }, '<Up>',
    function()
      jumpParagraph:activate()
      prevParagraphStart()
    end)
  map({ 'n', 'x', }, '<S-Up>',
    function()
      jumpParagraph:activate()
      prevParagraphEnd()
    end)
  map({ 'n', 'x', }, '<S-Down>',
    function()
      jumpParagraph:activate()
      nextParagraphEnd()
    end)
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
  splitjoin = splitjoin,
  fm = fm,
  lspconfig = lspconfig,
  bufferline = bufferline,
  coq = coq,
  fzf = fzf,
  dial = dial,
  gitsigns = gitsigns,
  textobjchainmember = textobjchainmember,
  hydra = hydra,
  leap = leap,
  bettern = bettern,
  pulse = pulse,
  sj = sj,
  codeactionmenu = codeactionmenu,
  mason = mason,
  dap = dap,
  comment = comment,
  ssr = ssr,
  sniprun = sniprun,
  sideways = sideways,
  putter = putter,
  matchup = matchup,
  tablemode = tablemode,
  varioustextobjs = varioustextobjs,
  printer = printer,
  spider = spider,
}
