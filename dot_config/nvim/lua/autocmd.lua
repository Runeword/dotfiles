local cmd = vim.cmd
local fn = vim.fn
local highlight = vim.highlight
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local hi = vim.api.nvim_set_hl

local function core()
  augroup("chezmoi", { clear = true })
  augroup("tmux", { clear = true })
  augroup("bash", { clear = true })
  augroup("diagnostic", { clear = true })
  augroup("qf", { clear = true })
  augroup("disableAutoComment", { clear = true })
  -- augroup("yank", { clear = true })

  -- autocmd("TextYankPost", {
  --   group = "yank",
  --   pattern = "*",
  --   callback = function() pcall(highlight.on_yank, { higroup = "Yank", timeout = 150 }) end
  -- })

  autocmd("BufWritePost", {
    group = "chezmoi",
    pattern = "~/.local/share/chezmoi/*",
    command = "silent! !chezmoi apply --source-path %",
  })

  autocmd("BufWritePost", {
    group = "tmux",
    pattern = "~/.config/tmux/tmux.conf",
    command = "silent! !tmux source-file ~/.config/tmux/.tmux.conf",
  })

  -- autocmd("BufWritePost", {
  --   group = "bash",
  --   pattern = "~/.bash_aliases",
  --   command = "silent! source ~/.bash_aliases",
  -- })

  -- autocmd("BufWritePost", {
  --   group = "bash",
  --   pattern = "~/.bashrc",
  --   command = "silent! source ~/.bashrc",
  -- })

  autocmd("ColorScheme", {
    group = "diagnostic",
    pattern = "*",
    callback = function()
      hi(0, 'DiagnosticFloatingError', { link = 'DiagnosticVirtualTextError' })
      hi(0, 'DiagnosticFloatingHint', { link = 'DiagnosticVirtualTextHint' })
      hi(0, 'DiagnosticFloatingInfo', { link = 'DiagnosticVirtualTextInfo' })
      hi(0, 'DiagnosticFloatingWarn', { link = 'DiagnosticVirtualTextWarn' })
      hi(0, 'NormalFloat', { bg = 'none' })
      hi(0, 'FloatBorder', { bg = 'none', fg = '#001b47' })
      hi(0, 'Yank', { bg = '#00ffa2', fg = 'black' })
      -- hi(0, 'IncSearch', { bg = '#00ffa2', fg = 'black' })
      -- hi(0, 'Pmenu', { bg = 'white', fg = 'black' })
    end
  })

  autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile' }, {
    group = 'disableAutoComment',
    pattern = "*",
    command = "setlocal fo-=c fo-=r fo-=o fo+=t",
  })

  -- Exclude quickfix buffer from the buffer list
  autocmd("FileType", {
    group = "qf",
    pattern = "qf",
    command = "set nobuflisted",
  })

  -- Automatically fitting a quickfix window to 10 lines max and 3 lines min height
  autocmd("FileType", {
    group = "qf",
    pattern = "qf",
    callback = function() cmd(math.max(math.min(fn.line("$"), 10), 3) .. "wincmd _") end,
  })
end

local function bufferline()
  augroup("bufferline", { clear = true })
  autocmd("ColorScheme", {
    group = "bufferline",
    pattern = "*",
    callback = function()
      hi(0, 'BufferLineFill', { bg = 'none' })
      hi(0, 'BufferLineBackground', { fg = '#7a7c9e' })
      hi(0, 'BufferLineBufferSelected', { fg = 'white', bg = 'none' })
    end
  })
end

local function matchup()
  augroup("matchup", { clear = true })
  autocmd("ColorScheme", {
    group = "matchup",
    pattern = "*",
    callback = function()
      hi(0, 'MatchParen', { fg = '#7429ff', italic = true, bold = true })
      hi(0, 'MatchWord', { fg = '#7429ff' })
      hi(0, 'MatchBackground', { bg = '#222277'})
    end
  })
end

local function lightbulb()
  augroup("lightbulb", { clear = true })
  autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = "lightbulb",
    pattern = "*",
    callback = require('nvim-lightbulb').update_lightbulb
  })
end

local function packer()
  augroup("packer_user_config", { clear = true })
  autocmd("BufWritePost", {
    group = "packer_user_config",
    pattern = "*/.config/nvim/**",
    command = "PackerCompile",
  })
end

local function coq()
  augroup("coq", { clear = true })
  autocmd("BufWritePost", {
    group = "coq",
    pattern = "*/.config/nvim/coq-user-snippets/*.snip",
    command = "silent! COQsnips compile",
  })
end

local function indentscope()
  augroup("indentscope", { clear = true })
  autocmd("FileType", {
    group = "indentscope",
    pattern = "*",
    command = "if index(['help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'NvimTree', 'neo-tree', 'Trouble'], &ft) != -1 || index(['nofile', 'terminal', 'lsp-installer', 'lspinfo'], &bt) != -1 | let b:miniindentscope_disable=v:true | endif",
  })
end

-- local function leap()
--   augroup("leap", { clear = true })
--   autocmd("ColorScheme", {
--     group = "leap",
--     pattern = "*",
--     callback = function()
--       require('leap').init_highlight(true)
--       hi(0, 'LeapBackdrop', { bg = 'none', })
--       hi(0, 'LeapLabelPrimary', { bg = '#ccff88', fg = 'black' })
--       hi(0, 'LeapLabelSecondary', { fg = 'red', })
--       hi(0, 'LeapMatch', { bg = '#77aaff', fg = 'black' })
--     end
--   })
-- end

local function sj()
  augroup("sj", { clear = true })
  autocmd("ColorScheme", {
    group = "sj",
    pattern = "*",
    callback = function()
      hi(0, 'SjFocusedLabel', { bg = '#00fbff', fg = 'black' })
      -- hi(0, 'SjLabel', { bg = '#ccff88', fg = 'black' })
      -- hi(0, 'SjSearch', { bg = '#77aaff', fg = 'black' })
    end
  })
end

-- cmd([[
-- autocmd ColorScheme * highlight CursorLine gui=bold guibg=none
-- autocmd ColorScheme * highlight VertSplit guifg=#292e42
-- autocmd ColorScheme * highlight Hlargs guifg=#FAFF00
-- ]])

-- local function telescope()
--   cmd([[autocmd ColorScheme * highlight TelescopeBorder guibg=none]])
--   cmd([[autocmd ColorScheme * highlight TelescopeNormal guibg=none]])
-- end

return {
  packer = packer,
  indentscope = indentscope,
  core = core,
  bufferline = bufferline,
  coq = coq,
  lightbulb = lightbulb,
  sj = sj,
  matchup = matchup,
}
