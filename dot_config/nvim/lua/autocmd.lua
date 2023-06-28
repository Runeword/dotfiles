local cmd = vim.cmd
local o = vim.o
local fn = vim.fn
local highlight = vim.highlight
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local nvim_set_hl = vim.api.nvim_set_hl

local function core()
  augroup('chezmoi', { clear = true, })
  augroup('tmux', { clear = true, })
  augroup('bash', { clear = true, })
  augroup('diagnostic', { clear = true, })
  augroup('quickfix', { clear = true, })
  augroup('disableAutoComment', { clear = true, })
  augroup('term', { clear = true, })

  autocmd('TermOpen', {
    group = 'term',
    callback = function()
      o.relativenumber = false
      o.number = false
      cmd('startinsert')
    end,
  })

  autocmd('BufWritePost', {
    group = 'chezmoi',
    pattern = '~/.local/share/chezmoi/*',
    command = 'silent! !chezmoi apply --source-path %',
  })

  autocmd('BufWritePost', {
    group = 'tmux',
    pattern = '~/.config/tmux/tmux.conf',
    command = 'silent! !tmux source-file ~/.config/tmux/.tmux.conf',
  })

  autocmd('ColorScheme', {
    group = 'diagnostic',
    pattern = '*',
    callback = function()
      nvim_set_hl(0, 'DiagnosticFloatingError',
        { link = 'DiagnosticVirtualTextError', })
      nvim_set_hl(0, 'DiagnosticFloatingHint',
        { link = 'DiagnosticVirtualTextHint', })
      nvim_set_hl(0, 'DiagnosticFloatingInfo',
        { link = 'DiagnosticVirtualTextInfo', })
      nvim_set_hl(0, 'DiagnosticFloatingWarn',
        { link = 'DiagnosticVirtualTextWarn', })
      nvim_set_hl(0, 'NormalFloat', { bg = 'none', })
      nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = '#1e2633', })
      nvim_set_hl(0, 'Yank', { bg = '#00ffa2', fg = 'black', })
      nvim_set_hl(0, 'Pmenu', { bg = 'black', fg = '#7a7c9e', })
      nvim_set_hl(0, 'PmenuSel', { bg = '#1e2633', fg = 'white', })
      nvim_set_hl(0, 'PmenuSbar', { bg = 'black', })
      nvim_set_hl(0, 'PmenuThumb', { bg = '#1e2633', })
      nvim_set_hl(0, 'CursorLine', { bg = '#1e2633', })
      nvim_set_hl(0, 'CursorColumn', { bg = '#1e2633', })
      nvim_set_hl(0, 'Search', { bg = '#5d00ff', })
      nvim_set_hl(0, 'Normal', { bg = 'none', })

      -- nvim_set_hl(0, 'VertSplit', { fg = '#292e42' })
      -- nvim_set_hl(0, 'Hlargs', { fg = '#FAFF00' })
      -- nvim_set_hl(0, 'IncSearch', { bg = '#00ffa2', fg = 'black' })
      -- #0a172e #1e2633 #7a7c9e
    end,
  })

  autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile', }, {
    group = 'disableAutoComment',
    pattern = '*',
    command = 'setlocal fo-=c fo-=r fo-=o fo+=t',
  })

  -- Exclude quickfix buffer from the buffer list
  autocmd('FileType', {
    group = 'quickfix',
    pattern = 'qf',
    command = 'set nobuflisted',
  })

  -- Automatically fitting a quickfix window to 10 lines max and 3 lines min height
  autocmd('FileType', {
    group = 'quickfix',
    pattern = 'qf',
    callback = function()
      cmd(math.max(math.min(fn.line('$'), 10), 3) ..
        'wincmd _')
    end,
  })
end

local function bufferline()
  augroup('bufferline', { clear = true, })
  autocmd('ColorScheme', {
    group = 'bufferline',
    pattern = '*',
    callback = function()
      nvim_set_hl(0, 'BufferLineFill', { bg = 'none', })
      nvim_set_hl(0, 'BufferLineBackground', { fg = '#7a7c9e', })
      nvim_set_hl(0, 'BufferLineBufferSelected', { fg = 'white', bg = 'none', })
      nvim_set_hl(0, 'BufferLineNumbers',
        { fg = '#7a7c9e', bg = 'none', italic = false, })
      nvim_set_hl(0, 'BufferLineNumbersSelected',
        { fg = 'white', bg = 'none', italic = false, })
      nvim_set_hl(0, 'BufferLineDuplicate',
        { fg = '#7a7c9e', bg = 'none', italic = false, })
      nvim_set_hl(0, 'BufferLineDuplicateSelected',
        { fg = 'white', bg = 'none', italic = false, })
    end,
  })
end

local function matchup()
  augroup('matchup', { clear = true, })
  autocmd('ColorScheme', {
    group = 'matchup',
    pattern = '*',
    callback = function()
      nvim_set_hl(0, 'MatchParen',
        { fg = '#7429ff', italic = true, bold = true, })
      nvim_set_hl(0, 'MatchWord', { fg = '#7429ff', })
      nvim_set_hl(0, 'MatchBackground', { bg = '#1a1a3b', })
    end,
  })
end

local function lightbulb()
  augroup('lightbulb', { clear = true, })
  autocmd({ 'CursorHold', 'CursorHoldI', }, {
    group = 'lightbulb',
    pattern = '*',
    callback = require('nvim-lightbulb').update_lightbulb,
  })
end

local function lualine()
  -- augroup('lualine', { clear = true, })
  -- autocmd({ 'User', 'LspProgressStatusUpdated', }, {
  --   group = 'lualine',
  --   pattern = '*',
  --   callback = require('lualine').refresh(),
  -- })
  vim.cmd([[
  augroup lualine
      autocmd!
      autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
  augroup END
  ]])
end

local function packer()
  augroup('packer_user_config', { clear = true, })
  autocmd('BufWritePost', {
    group = 'packer_user_config',
    pattern = '*/.config/nvim/**',
    command = 'PackerCompile',
  })
end

local function coq()
  augroup('coq', { clear = true, })
  autocmd('BufWritePost', {
    group = 'coq',
    pattern = '*/.config/nvim/coq-user-snippets/*.snip',
    command = 'silent! COQsnips compile',
  })
end

local function indentscope()
  augroup('indentscope', { clear = true, })
  autocmd('FileType', {
    group = 'indentscope',
    pattern = '*',
    command =
    "if index(['help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'NvimTree', 'neo-tree', 'Trouble'], &ft) != -1 || index(['nofile', 'terminal', 'lsp-installer', 'lspinfo'], &bt) != -1 | let b:miniindentscope_disable=v:true | endif",
  })
end

local function sj()
  augroup('sj', { clear = true, })
  autocmd('ColorScheme', {
    group = 'sj',
    pattern = '*',
    callback = function()
      nvim_set_hl(0, 'SjFocusedLabel',
        { bg = '#ffe100', fg = 'black', bold = false, })
      nvim_set_hl(0, 'SjLabel', { bg = '#5d00ff', fg = 'white', bold = false, })
      nvim_set_hl(0, 'SjMatches', { bg = '#222b66', fg = 'white', bold = false, })
    end,
  })
end

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
  lualine = lualine,
}
