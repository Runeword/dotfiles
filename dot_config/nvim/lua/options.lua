local o = vim.o
local g = vim.g
local fn = vim.fn
local opt = vim.opt
local cmd = vim.cmd

local function core()
  -- cmd([[color haslo]])
  -- cmd([[colorscheme blaster]])

  -- o.scroll = 5
  -- opt.fillchars:append("horiz:.")
  -- g.mapleader = " "
  -- cmd([[let mapleader = "\<enter>"]])
  cmd([[let mapleader = "\<BS>"]])
  o.mouse = "a" -- Enables mouse support
  o.cursorline = false
  o.cursorcolumn = true
  o.statuscolumn='%s%=%l %C%#Yellow#%{v:relnum == 0 ? ">" : ""}%#IndentBlankLineChar#%{v:relnum == 0 ? "" : " "}'
  o.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor
  o.foldenable = false -- All folds are open
  o.number = true -- Print the line number in front of each line
  -- o.relativenumber = true -- Show relative line numbers
  o.virtualedit = "all"
  -- o.cmdheight=0
  o.cmdheight = 1
  o.wildcharm = ('\t'):byte()
  o.wildignorecase = true
  -- o.shortmess='a'
  o.completeopt = "menuone,noinsert" -- Options for Insert mode completion
  o.pumblend = 15
  o.clipboard = "unnamedplus" -- Have the clipboard be the same as my regular clipboard
  o.updatetime = 50 -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience
  -- o.timeoutlen = 0
  o.swapfile = false
  o.termguicolors = true -- Enables 24-bit RGB color in the Terminal UI
  o.showmode = false -- Disable message on the last line (Insert, Replace or Visual mode)
  o.linebreak = true -- Do not break words on line wrap
  o.breakindent = true -- Start wrapped lines indented
  -- o.formatoptions = "cro"
  -- vim.cmd([[filetype plugin indent on]])
  -- o.showtabline=2  -- Always display the line with tab page labels
  o.ignorecase = true -- Ignore case in search patterns
  o.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters
  -- opt.iskeyword:remove({ "/", "(", "[", "{" })
  -- opt.iskeyword:append({ "/", "(", "[", "{" })
  o.signcolumn = "yes:1"
  o.expandtab = true -- Use the appropriate number of spaces to insert a <Tab>
  o.smartindent = true -- Do smart autoindenting when starting a new line
  o.copyindent = true -- Copy the structure of the existing lines indent when autoindenting a new line
  o.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
  o.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
  o.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
  o.hidden = true -- Allow switching buffers with unsaved changes
  opt.lazyredraw = true -- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up, upto 6-7x faster
  -- lukas-reineke/indent-blankline.nvim
  opt.list = true
  opt.listchars:append("eol:↴")
  opt.laststatus = 3

  -- nvim-treesitter/nvim-treesitter
  o.foldmethod = "expr"
  o.foldexpr = "nvim_treesitter#foldexpr()"
end

-------------------- andymass/vim-matchup
local function matchup()
  g.loaded_matchit = 1
  g.matchup_matchparen_nomode = "i"
  g.matchup_mappings_enabled = 0
  g.matchup_matchparen_pumvisible = 0
  g.matchup_matchparen_deferred = 1
  g.matchup_matchparen_deferred_show_delay = 50
  g.matchup_matchparen_deferred_hide_delay = 50
  g.matchup_motion_override_Npercent = 0
  g.matchup_surround_enabled = 1
  g.matchup_motion_enabled = 1
  g.matchup_text_obj_enabled = 1
  g.matchup_transmute_enabled = 1
  g.matchup_matchparen_enabled = 1
  g.matchup_override_vimtex = 1
  g.matchup_matchparen_hi_background = 1
  g.matchup_matchparen_offscreen = { method = "popup", fullwidth = 1, }
end

return {
  core = core,
  matchup = matchup,
}

-- local function textobjuser()
-- fn["textobj#user#plugin"]("specialcharacters", {
--   move = {
--     pattern = [[\(\W\&\S\)\+]],
--     ["move-n"] = "W",
--     ["move-p"] = "B",
--     ['move-N'] = 'E',
--     ['move-P'] = 'gE',
--   },
-- })
--
-- cmd([[
-- call textobj#user#plugin('word', {
--   \   'move': {
--   \   'pattern': '\<\w\+\>',
--   \     'move-n': 'w',
--   \     'move-p': 'b',
--   \     'move-N': 'e',
--   \     'move-P': 'ge',
--   \   },
--   \ })
-- ]])

-- fn["textobj#user#plugin"]("specialcharacters", {
--   move = {
--     pattern = [[\(\W\&\S\)\+]],
--     ["move-n"] = "W",
--     ["move-p"] = "B",
-- ['move-N'] = 'E',
-- ['move-P'] = 'gE',
-- },
-- special_i = {
--   select = "iW",
-- 	pattern = [[\(\W\&\S\)\+]],
--   },
-- special_a = {
--   select = "aW",
-- 	pattern = [[\s*\(\W\&\S\)\+\s*]],
--   },
-- })

-- pattern = [[\(\w\|\s\)\@!]],
-- \   'pattern': '\[[:alnum:]]\+',
-- \   'pattern': '^\s*\zs\w\+\s*\|\s*\w\+\s*'
-- \   'pattern': '\(\s*\w\+\s*\)\(\W\)\@='
--   \   'word_a': {
--  \     'select': 'aw',
--  \     'pattern': '^\s*\zs\w\+\s*\|\s*\w\+\s*'
-- \   },

--  cmd([[
-- call textobj#user#plugin('word', {
--   \   'move': {
--    \   'pattern': '\<\w\+\>',
--    \     'move-n': 'w',
--   \     'move-p': 'b',
--   \     'move-N': 'e',
--   \     'move-P': 'ge',
--   \   },
--    \   'word_i': {
--   \   'select': 'iw',
--   \     'pattern': '\w\+'
--    \   },
--    \   'word_I': {
--   \     'select': 'Iw',
--   \     'pattern': '\(\W*\&\S*\)\w\+\(\W*\&\S*\)'
--    \   },
--    \ })
-- ]])

-- cmd([[
-- -- -- \     'pattern': '\s*\<\w\+\>\s*'
-- "     call textobj#user#plugin('handyobjects', {
-- " \   'underscores_a': {
-- " \     'select': 'ar',
-- " \     'pattern': '_\_[^_]*_'
-- " \   },
-- " \   'underscores_i': {
-- " \     'select': 'ir',
-- " \     'pattern': '_\zs\_[^_]\+\ze_'
-- " \   },
-- " \ })
-- call textobj#user#plugin('contiuous', {
--   \   'continuous': {
--   \     'pattern': '\S\+',
--   \     'move-n': 'w',
--   \     'move-p': 'b',
--   \     'move-N': 'e',
--   \     'move-P': 'ge',
--   \   },
--   \   'continuous_a': {
--   \     'select': 'aw',
--   \     'pattern': '\s\S\+\s'
--   \   },
--   \ })
--    ]])
-- \     'select': ['aw', 'iw'],
-- call textobj#user#plugin('contiuous', {
--   \   'continuous': {
--   \     'pattern': '\S\+',
--   \     'select': ['aw', 'iw'],
--   \     'move-n': 'w',
--   \     'move-p': 'b',
--   \     'move-N': 'e',
--   \     'move-P': 'ge',
--   \   },
--   \ })
--   ]])
-- fn["textobj#user#plugin"]("whitespaces", {
-- whitespaces = {
-- 	pattern = [[\S\zs\s\+]],
-- 	["move-n"] = "s",
-- 	["move-p"] = "S",
-- },
-- })
-- fn["textobj#user#plugin"]("word", {
-- 	word = {
-- 		pattern = [[\<\w\+\>]],
-- 		["move-n"] = "w",
-- 		["move-p"] = "b",
-- 		["move-N"] = "e",
-- 		["move-P"] = "ge",
-- 		select = "iw",
-- 	},
-- })
-- pattern = [[\S\+]],
-- end
