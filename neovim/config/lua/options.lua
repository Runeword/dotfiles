local vim = vim
local o = vim.o
local opt = vim.opt

-- vim.cmd([[color haslo]])
-- vim.cmd([[colorscheme blaster]])

-- vim.cmd([[let mapleader = "\<Enter>"]]) -- vim.cmd([[let mapleader = "\<BS>"]])
vim.cmd([[let mapleader = "\<Space>"]])

o.splitright = true
o.splitkeep = 'screen'
o.mouse = 'a' -- Enables mouse support
o.cursorline = true
o.cursorcolumn = false
o.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor
o.number = true -- Print the line number in front of each line
o.virtualedit = 'all'
o.cmdheight = 1
o.wildcharm = ('\t'):byte()
o.wildignorecase = true
o.completeopt = 'menuone,noinsert' -- Options for Insert mode completion
o.pumblend = 10
-- o.pumwidth = 40
-- o.pumheight = 15
o.clipboard =
'unnamedplus'          -- Have the clipboard be the same as my regular clipboard
o.updatetime = 50      -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience
o.swapfile = false
o.termguicolors = true -- Enables 24-bit RGB color in the Terminal UI
o.showmode = false     -- Disable message on the last line (Insert, Replace or Visual mode)
o.linebreak = true     -- Do not break words on line wrap
o.breakindent = true   -- Start wrapped lines indented
o.ignorecase = false    -- Ignore case in search patterns
o.smartcase = false     -- Override the 'ignorecase' option if the search pattern contains upper case characters
o.signcolumn = 'yes:1'
o.expandtab = true     -- Use the appropriate number of spaces to insert a <Tab>
o.smartindent = true   -- Do smart autoindenting when starting a new line
o.copyindent = true    -- Copy the structure of the existing lines indent when autoindenting a new line
o.softtabstop = 2      -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
o.tabstop = 2          -- Number of spaces that a <Tab> in the file counts for
o.shiftwidth = 2       -- Number of spaces to use for each step of (auto)indent
o.hidden = true        -- Allow switching buffers with unsaved changes
opt.lazyredraw = true  -- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up, upto 6-7x faster
opt.viminfofile = vim.fn.stdpath("cache") .. "/viminfo" -- Set viminfofile to XDG cache directory
opt.list = true
opt.listchars:append 'eol:¬,nbsp:•,tab:  ,lead: ,multispace:˙,trail:˙'
opt.laststatus = 3
opt.showcmd = false
-- opt.spell = true
-- opt.spelllang = { 'en_us', }
o.fillchars = 'eob: '
-- o.cmdheight=0

--------------------------- Enable fold

o.foldenable = false
o.wrap = false

-- o.fillchars = [[eob: ,fold: ,foldopen:-,foldclose:+]]
-- o.foldopen = 'search,undo'
-- -- nvim-treesitter/nvim-treesitter
-- o.foldmethod = 'expr'
-- o.foldexpr = 'nvim_treesitter#foldexpr()'
-- -- kevinhwang91/nvim-ufo
-- o.foldcolumn = '1'
-- o.foldlevel = 99
-- o.foldlevelstart = 99
-- o.foldenable = true

-- local fcs = vim.opt.fillchars:get()
-- local function get_fold(lnum)
--   if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end
--   return vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
-- end
-- _G.get_statuscol = function()
--   return "%s%l " .. get_fold(vim.v.lnum) .. " "
-- end
-- vim.o.statuscolumn = "%!v:lua.get_statuscol()"
