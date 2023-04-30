local cmd = vim.cmd
local fn = vim.fn
local o = vim.o
local g = vim.g
local map = vim.keymap.set
local call = vim.call
local api = vim.api
local feedkeys = vim.api.nvim_feedkeys
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local diagnostic = vim.diagnostic
local lsp = vim.lsp
local silent = { silent = true }
local expr = { expr = true }
local remap = { remap = true }

local function core()
  map("x", "<C-n>", ":Norm ")
  map("n", "<Leader>ch", "<cmd>silent !google-chrome-stable %:p<CR>")
  -- map("n", ";", ":", { noremap = true })
  -- map("n", ":", ";", { noremap = true })

  -- Help
  cmd [[command! -nargs=1 -complete=help H h <args> | only]]
  cmd [[cnoreabbrev <expr> h  getcmdtype() == ":" && getcmdline() == 'h' ? 'H' : 'h']]

  -- Terminal
  map('n', '<Leader>t', '<cmd>te<CR>')
  map('t', '<Esc>', [[<C-\><C-n>]])

  -- Unmap
  map('n', '<Enter>', '<Nop>')
  map('n', '<C-n>', '<Nop>')
  map('n', '<C-p>', '<Nop>')
  map("", "Q", "<Nop>")
  map("", "q", "<Nop>")

  -- Save
  map("n", "<C-s>", "<cmd>silent write<CR>")
  map("i", "<C-s>", "<Esc>`^<cmd>silent write<CR>")

  -- Edit
  map("i", "ù", "<Esc>`^u")

  -- Text objects
  map({ 'x', 'o' }, "a<Leader>", "ap")
  map({ 'x', 'o' }, "i<Leader>", "ip")
  map({ 'o' }, "<Leader>", "ip")

  map({ 'x', 'o' }, "q", "iq", remap)
  map({ 'x', 'o' }, "nq", "inq", remap)
  map({ 'x', 'o' }, "oq", "ioq", remap)

  map({ 'x', 'o' }, "a", "ia", remap)
  map({ 'x', 'o' }, "na", "ina", remap)
  map({ 'x', 'o' }, "oa", "ioa", remap)

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
  -- fn['arpeggio#map']('ox', '', 0, '()', 'a)')
  -- fn['arpeggio#map']('ox', '', 0, '{}', 'a}')
  -- fn['arpeggio#map']('ox', '', 0, '[]', 'a]')

  -- Operators
  map("x", "p", '"_dP')
  map({ "n", "v" }, "d", '"_d')
  map("n", "D", '"_D')
  map("n", "dd", '"_dd^')
  map({ "n", "v" }, "x", '"_x')
  map({ "n", "v" }, "m", 'd')
  map("n", "M", 'D')
  map("n", "mm", 'dd^')

  -- Readline
  map("i", "<C-a>", "<esc>I")
  map("i", "<C-e>", "<end>")
  map("i", "<C-k>", "<esc>ld$i")
  map("i", "<C-H>", "<C-w>")

  -- Motions
  map("n", "k", "gk")
  map("n", "j", "gj")
  map("n", "0", "g0")
  map("n", "$", function() fn.execute("normal! g$")
    o.ve = ''
    o.ve = 'all'
  end)
  map("n", "^", "g^")
  map("n", "&", "g^")
  map('n', '(', function() fn.search('(') end)
  map('n', ')', function() fn.search('(', 'b') end)
  map('n', '[', function() fn.search('[') end)
  map('n', ']', function() fn.search('[', 'b') end)
  map('n', '{', function() fn.search('{') end)
  map('n', '}', function() fn.search('{', 'b') end)

  -- Buffers
  map("n", "<Leader>w", "<C-w>", { noremap = true })
  map("n", "<C-t>", "<cmd>enew<CR>", silent)
  map("n", "<C-w>", "<cmd>bwipeout!<CR>", silent)
  -- map("n", "<Tab>", "<cmd>bnext<CR>", silent)
  -- map("n", "<S-Tab>", "<cmd>bprevious<CR>", silent)

  map("n", "<C-q>", '<cmd>q!<CR>')

  -------------------- folke/lazy.nvim
  map('n', '<leader>l', '<cmd>Lazy<CR>')

end

-------------------- chrisgrieser/nvim-spider
local function spider()
  map({"n", "o", "x"}, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
  map({"n", "o", "x"}, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-w" })
  map({"n", "o", "x"}, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-w" })
  map({"n", "o", "x"}, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-w" })
end
-------------------- Runeword/putter.nvim
local function putter()
  map({ "n", "x" }, "glp", require("putter").putLinewise(']p`]'))
  map({ "n", "x" }, "glP", require("putter").putLinewise(']P`]'))
  map({ "n", "x" }, "gllp", require("putter").putLinewiseSuffix(']p`]'))
  map({ "n", "x" }, "gllP", require("putter").putLinewiseSuffix(']P`]'))
  map({ "n", "x" }, "glsp", require("putter").putLinewiseSurround(']p`]'))
  map({ "n", "x" }, "glsP", require("putter").putLinewiseSurround(']P`]'))
  map({ "n", "x" }, "p", require("putter").putCharwise('p'))
  map({ "n", "x" }, "P", require("putter").jumpToLineStart(require("putter").putCharwise('P')))
  map({ "n", "x" }, "gp", require("putter").putCharwisePrefix('p'))
  map({ "n", "x" }, "gP", require("putter").putCharwiseSuffix('P'))
  map({ "n", "x" }, "gsp", require("putter").putCharwiseSurround('p'))
  map({ "n", "x" }, "gsP", require("putter").putCharwiseSurround('P'))
  -- map({ "n", "x" }, "x", require("putter").snapToLineEnd('"_x'))
  -- map({ "n", "x" }, "p", require("putter").jumpToLineEnd(require("putter").putCharwise('p')))
  -- map({ "n", "x" }, "gp", require("putter").putCharwisePrefix('geep'))
  -- map({ "n", "x" }, "gP", require("putter").putCharwiseSuffix('gewP'))
  -- map({ "n", "x" }, "gsp", require("putter").putCharwiseSurround('geep'))
  -- map({ "n", "x" }, "gsP", require("putter").putCharwiseSurround('gewP'))

  -- map("n", "<leader><Tab>", require("putter").addBuffersToQfList)
  -- map("n", "<C-down>", require("putter").cycleNextLocItem, silent)
  -- map("n", "<C-up>", require("putter").cyclePrevLocItem, silent)
  -- map("n", "<C-q>", "&buftype is# 'quickfix' ? ':try | cclose | catch | q! | catch | endtry<CR>' : ':q!<CR>'", expr)

  -- vim.keymap.set("n", "t", require("putter").__dot_repeat('p'))

  -- local counter = 0
  --
  -- function _G.__dot_repeat(motion) -- 4.
  --     if motion == nil then
  --         vim.o.operatorfunc = "v:lua.require('putter').snapToLineEnd('_x')()"
  --         return "g@$" -- 2.
  --     end
  --
  --     -- print("counter:", counter, "motion:", motion)
  --     counter = counter + 1
  -- end
  --
  -- vim.keymap.set("n", "ga", _G.__dot_repeat, expr)

  -- -- stylua: ignore
end

-------------------- nvim-telescope/telescope.nvim
local function telescope()
  -- map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", opts)
  -- map("n", "<leader>s", "<cmd>Telescope live_grep<cr>", opts)
  -- map("n", "<leader>b", "<cmd>Telescope buffers<cr>", opts)
end

-------------------- williamboman/mason.nvim
local function mason()
  map("n", "<Leader>m", '<cmd>Mason<Cr>')
end

-------------------- junegunn/fzf
local function fzf()
  map("n", "<Leader><Leader>", require('fzf-lua').files)
  map("n", "<Leader>h", require('fzf-lua').live_grep_resume)
  map("n", "<Leader>sh", require('fzf-lua').help_tags)
  map("n", "<Leader>sm", require('fzf-lua').keymaps)
  map("n", "<Leader>sl", require('fzf-lua').highlights)
  -- map("n", "<Leader>x", "<cmd>lua require('fzf-lua').quickfix({multiprocess=true})<CR>")
end

-------------------- andymass/vim-matchup
local function matchup()
  map({ "n", "x" }, "%", '<plug>(matchup-%)')
  map({ "n", "x" }, "g%", '<plug>(matchup-g%)')
end

-------------------- jonatan-branting/nvim-better-n
local function bettern()
  map("n", "n", require("better-n").n, { nowait = true })
  map("n", "<s-n>", require("better-n").shift_n, { nowait = true })
end

-------------------- inside/vim-search-pulse
local function pulse()
  g.vim_search_pulse_duration = 200
  g.vim_search_pulse_mode = 'pattern'
  g.vim_search_pulse_disable_auto_mappings = 1

  map("n", "n", "n<Plug>Pulse", remap)
  map("n", "N", "N<Plug>Pulse", remap)
  map("n", "*", "*<Plug>Pulse", remap)
  map("n", "#", "#<Plug>Pulse", remap)
  map("c", "<Enter>", "search_pulse#PulseFirst()", { silent = true, expr = true })
end

local function comment()
  map('x', 'gc', '<Plug>(comment_toggle_linewise_visual)gv', remap)
  map('x', 'gb', '<Plug>(comment_toggle_blockwise_visual)gv', remap)
end

-------------------- AndrewRadev/sideways.vim
local function sideways()
  map("n", "<Left>", "<cmd>SidewaysJumpLeft<CR>")
  map("n", "<Right>", "<cmd>SidewaysJumpRight<CR>")
  map("n", "<C-Left>", "<cmd>SidewaysLeft<CR>")
  map("n", "<C-Right>", "<cmd>SidewaysRight<CR>")
end

-------------------- ggandor/leap.nvim
local function leap()
  map({ "n", "x" }, "s", "<Plug>(leap-forward)", remap)
  map({ "n", "x" }, "S", "<Plug>(leap-backward)", remap)
end

-------------------- cshuaimin/ssr.nvim
local function ssr()
  map({ "n", "x" }, "t", function() require("ssr").open() end)
end

-------------------- woosaaahh/sj.nvim
local function sj()
  map({ 'n', 'o', 'x' }, 's', require("sj").run)
end

-------------------- dhruvasagar/vim-table-mode
local function tablemode()
  map('n', '<Leader>tt', '<Cmd>TableModeToggle<CR>')
end

-------------------- rareitems/printer.nvim
local function printer()
  map("n", "<Leader>pw", "<Plug>(printer_print)iw")
end

-------------------- chrisgrieser/nvim-various-textobjs
local function varioustextobjs()
  map({ "o", "x" }, "ak", function() require("various-textobjs").key(false) end)
  map({ "o", "x" }, "ik", function() require("various-textobjs").key(true) end)
  map({ "o", "x" }, "av", function() require("various-textobjs").value(false) end)
  map({ "o", "x" }, "iv", function() require("various-textobjs").value(true) end)
  map({ "o", "x" }, "ad", function() require("various-textobjs").number(false) end)
  map({ "o", "x" }, "id", function() require("various-textobjs").number(true) end)
end

-------------------- lewis6991/gitsigns.nvim
local function gitsigns(buffer)
  map({ 'n', 'x' }, "<leader>ga", package.loaded.gitsigns.stage_buffer, { buffer = buffer, desc = 'git add file' })
  map({ 'n', 'x' }, "<leader>gr", package.loaded.gitsigns.reset_buffer_index,
    { buffer = buffer, desc = 'git reset file' })
  map({ 'n', 'x' }, "<leader>gc", package.loaded.gitsigns.reset_buffer,
    { buffer = buffer, desc = 'git checkout -- file' })
  map({ 'n', 'x' }, "<leader>gb", package.loaded.gitsigns.toggle_current_line_blame,
    { buffer = buffer, desc = 'git blame' })
  map({ 'n', 'x' }, "<leader>gd", package.loaded.gitsigns.toggle_deleted, { buffer = buffer })
end

-------------------- akinsho/bufferline.nvim
local function bufferline()
  map({ "n", "x" }, "<tab>", "<cmd>BufferLineCycleNext<CR>", silent)
  map({ "n", "x" }, "<s-tab>", "<cmd>BufferLineCyclePrev<CR>", silent)
  map({ "n", "x" }, "<pageup>", "<cmd>BufferLineMovePrev<CR>", silent)
  map({ "n", "x" }, "<pagedown>", "<cmd>BufferLineMoveNext<CR>", silent)
  map({ "n", "t", "i", "x" }, "<A-1>", function() require("bufferline").go_to_buffer(1) end)
  map({ "n", "t", "i", "x" }, "<A-2>", function() require("bufferline").go_to_buffer(2) end)
  map({ "n", "t", "i", "x" }, "<A-3>", function() require("bufferline").go_to_buffer(3) end)
  map({ "n", "t", "i", "x" }, "<A-4>", function() require("bufferline").go_to_buffer(4) end)
  map({ "n", "t", "i", "x" }, "<A-5>", function() require("bufferline").go_to_buffer(5) end)
  map({ "n", "t", "i", "x" }, "<A-6>", function() require("bufferline").go_to_buffer(6) end)
  map({ "n", "t", "i", "x" }, "<A-7>", function() require("bufferline").go_to_buffer(7) end)
  map({ "n", "t", "i", "x" }, "<A-8>", function() require("bufferline").go_to_buffer(8) end)
  map({ "n", "t", "i", "x" }, "<A-9>", function() require("bufferline").go_to_buffer(-1) end)
end

-------------------- AndrewRadev/splitjoin.vim
local function splitjoin()
  g.splitjoin_split_mapping = ""
  g.splitjoin_join_mapping = ""
  map("n", "gj", "<cmd>silent SplitjoinJoin<CR>")
  map("n", "gk", "<cmd>silent SplitjoinSplit<CR>")
end

-------------------- is0n/fm-nvim
local function fm()
  map("n", "<leader>n", "<cmd>Vifm<CR>")
end

-------------------- monaqa/dial.nvim
local function dial()
  map("n", "<C-a>", require("dial.map").inc_normal())
  map("n", "<C-x>", require("dial.map").dec_normal())
  map("v", "<C-a>", require("dial.map").inc_visual())
  map("v", "<C-x>", require("dial.map").dec_visual())
  map("v", "g<C-a>", require("dial.map").inc_gvisual())
  map("v", "g<C-x>", require("dial.map").dec_gvisual())
end

-------------------- neovim/nvim-lspconfig
local function lspconfig(buffer)
  map("n", "gd", lsp.buf.definition, { buffer = buffer })
  map("n", "gr", lsp.buf.references, { buffer = buffer })
  map('n', '<Leader>f', lsp.buf.format, { buffer = buffer })
  map("n", '<Leader>a', '<cmd>CodeActionMenu<Enter>', { buffer = buffer })
  -- map('n', '<leader>r', function() lsp.buf.rename(fn.input('New Name: ')) end, { buffer = buffer })
  -- map("n", '<ScrollWheelUp>', diagnostic.goto_prev, { buffer = buffer })
  -- map("n", '<ScrollWheelDown>', diagnostic.goto_next, { buffer = buffer })
  map("n", '<PageUp>', diagnostic.goto_prev, { buffer = buffer })
  map("n", '<PageDown>', diagnostic.goto_next, { buffer = buffer })
  -- map('n', '<Leader>l', diagnostic.setloclist, { noremap = true, silent = true })
  map('n', '<Leader>x', diagnostic.setqflist, { noremap = true, silent = true })
  -- lsp.buf.formatting_seq_sync(nil, 6000, { 'tsserver', 'html', 'cssls', 'vuels', 'eslint' })
  -- lsp.buf.formatting_seq_sync
end

-------------------- weilbith/nvim-code-action-menu
local function codeactionmenu()
  -- map("n", '<leader>ca', '<cmd>CodeActionMenu<Enter>')
end

-------------------- ms-jpq/coq_nvim
local function coq()
  map('i', '<Esc>', function() return fn.pumvisible() == 1 and '<C-e><Esc>`^' or '<Esc>`^' end, expr)
  map('i', '<C-c>', function() return fn.pumvisible() == 1 and '<C-e><C-c>' or '<C-c>' end, expr)
  map('i', '<Tab>', function() return fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end, expr)
  map('i', '<S-Tab>', function() return fn.pumvisible() == 1 and '<C-p>' or '<BS>' end, expr)
  map('n', '<Leader>cs', function() require('coq').Snips('edit') end)
end

-------------------- anuvyklack/hydra.nvim
local function hydra()
  require('hydra')({ name = 'newline', mode = { 'n', 'x' }, body = 'g', heads = {
    { 'o', '<cmd>set paste<CR>m`o<Esc>``<cmd>set nopaste<CR>' },
    { 'O', '<cmd>set paste<CR>m`O<Esc>``<cmd>set nopaste<CR>' },
  } })

  local scroll = require('hydra')({
    mode = { 'n', 'x' },
    config = {
      hint = false,
      on_enter = function() o.scrolloff = 9999 end,
      on_exit = function() o.scrolloff = 5 end,
    },
    heads = {
      { 'u', '5k' },
      { 'e', '5j' },
    }
  })

  map({ 'n', 'x' }, "<Leader>e", function() scroll:activate() fn.execute("normal! 5j") end)
  map({ 'n', 'x' }, "<Leader>u", function() scroll:activate() fn.execute("normal! 5k") end)

  local nextParagraphStart = function() fn.search([[\(^$\n\s*\zs\S\)\|\(\S\ze\n*\%$\)]], 'sW') end
  local nextParagraphEnd = function() fn.search([[\(\n\s*\)\@<=\S\(.*\n^$\)\@=]], 'sW') end
  local prevParagraphStart = function() fn.search([[\(^$\n\s*\zs\S\)\|\(^\%1l\s*\zs\S\)]], 'sWb') end
  local prevParagraphEnd = function() fn.search([[\(\n\s*\)\@<=\S\(.*\n^$\)\@=]], 'sWb') end

  local jumpParagraph = require('hydra')({
    mode = { 'n', 'x' },
    config = {
      hint = false,
      on_enter = function() o.scrolloff = 9999 end,
      on_exit = function() o.scrolloff = 5 end,
    },
    heads = {
      { '<Down>', nextParagraphStart },
      { '<Up>', prevParagraphStart },
      { '<C-Up>', prevParagraphEnd },
      { '<C-Down>', nextParagraphEnd },
    }
  })

  map({ 'n', 'x' }, "<Down>", function() jumpParagraph:activate() nextParagraphStart() end)
  map({ 'n', 'x' }, "<Up>", function() jumpParagraph:activate() prevParagraphStart() end)
  map({ 'n', 'x' }, "<S-Up>", function() jumpParagraph:activate() prevParagraphEnd() end)
  map({ 'n', 'x' }, "<S-Down>", function() jumpParagraph:activate() nextParagraphEnd() end)

end

-------------------- michaelb/sniprun
local function sniprun()
  map({ 'n', 'v' }, '<leader>rr', '<Plug>SnipRun')
  map('n', '<leader>re', '<Plug>SnipReset')
  map('n', '<leader>rl', '<Plug>SnipLive')
  map('n', '<leader>rc', '<Plug>SnipClose')
  map('n', '<leader>ri', '<Plug>SnipInfo')
  map('n', '<leader>rm', '<Plug>SnipReplMemoryClean')
end

-------------------- D4KU/vim-textobj-chainmember
local function textobjchainmember()
  map({ 'o', 'x' }, "am", "<Plug>(textobj-chainmember-a)")
  map({ 'o', 'x' }, "im", "<Plug>(textobj-chainmember-i)")
  map({ 'o', 'x' }, "aom", "<Plug>(textobj-chainmember-last-a)")
  map({ 'o', 'x' }, "iom", "<Plug>(textobj-chainmember-last-i)")
  map({ 'o', 'x' }, "anm", "<Plug>(textobj-chainmember-next-a)")
  map({ 'o', 'x' }, "inm", "<Plug>(textobj-chainmember-next-i)")
end

-------------------- mfussenegger/nvim-dap
local function dap()
  local mappings = require('hydra')({ hint = '', mode = { 'o', 'n', 'x' },
    config = {
      -- hint = { type = 'cmdline' },
      hint = false,
      color = 'pink',
    },
    heads = {
      { 'c', require('dap').continue },
      { 'n', require('dap').step_over },
      { 'i', require('dap').step_into },
      { 'o', require('dap').step_out },
      { 'b', require('dap').toggle_breakpoint },
      { 'r', require('dap').repl.open },
      { 'q', nil, { exit = true } },
      { '<Esc>', nil, { exit = true } },
      { '<C-s>', nil, { exit = true } }
    }
  })

  map({ 'n', 'x' }, '<Leader>d', function() mappings:activate() end)
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
