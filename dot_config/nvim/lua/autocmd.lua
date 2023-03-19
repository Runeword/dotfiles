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
        { link = 'DiagnosticVirtualTextError' })
      nvim_set_hl(0, 'DiagnosticFloatingHint',
        { link = 'DiagnosticVirtualTextHint' })
      nvim_set_hl(0, 'DiagnosticFloatingInfo',
        { link = 'DiagnosticVirtualTextInfo' })
      nvim_set_hl(0, 'DiagnosticFloatingWarn',
        { link = 'DiagnosticVirtualTextWarn' })
      nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = '#1e2633' })
      nvim_set_hl(0, 'Yank', { bg = '#00ffa2', fg = 'black' })
      nvim_set_hl(0, 'Pmenu', { bg = 'black', fg = '#7a7c9e' })
      nvim_set_hl(0, 'PmenuSel', { bg = '#1e2633', fg = 'white' })
      nvim_set_hl(0, 'PmenuSbar', { bg = 'black' })
      nvim_set_hl(0, 'PmenuThumb', { bg = '#1e2633' })
      nvim_set_hl(0, 'CursorLine', { bg = '#1e2633' })
      nvim_set_hl(0, 'CursorColumn', { bg = '#1e2633' })

      -- nvim_set_hl(0, 'VertSplit', { fg = '#292e42' })
      -- nvim_set_hl(0, 'Hlargs', { fg = '#FAFF00' })
      -- nvim_set_hl(0, 'IncSearch', { bg = '#00ffa2', fg = 'black' })
      -- #0a172e #1e2633 #7a7c9e
    end,
  })

  autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile' }, {
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
      -- nvim_set_hl(0, 'BufferLineFill', { bg = 'none' })
      nvim_set_hl(0, 'BufferLineBackground', { fg = '#7a7c9e' })
      nvim_set_hl(0, 'BufferLineBufferSelected', { fg = 'white', bg = 'none' })

      -- BufferLineInfoDiagnostic xxx cterm= gui= guifg=#1b5767 guisp=#81a2ac
      -- BufferLineInfo xxx cterm= gui= guifg=#24748a guisp=#add8e6
      -- BufferLineInfoVisible xxx cterm= gui= guifg=#24748a
      -- BufferLineHintDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#9e9e9e guisp=#9e9e9e
      -- BufferLineHintDiagnosticVisible xxx cterm= gui= guifg=#1b5767
      -- BufferLineHintDiagnostic xxx cterm= gui= guifg=#1b5767 guisp=#9e9e9e
      -- BufferLineHintSelected xxx cterm=bold,italic gui=bold,italic guifg=#d3d3d3 guisp=#d3d3d3
      -- BufferLineHintVisible xxx cterm= gui= guifg=#24748a
      -- BufferLineDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#bebda1
      -- BufferLineDiagnosticVisible xxx cterm= gui= guifg=#1b5767
      -- BufferLineNumbersVisible xxx cterm= gui= guifg=#24748a
      -- BufferLineBufferSelected xxx cterm=bold,italic gui=bold,italic guifg=#fefcd7
      -- BufferLineCloseButtonSelected xxx cterm= gui= guifg=#fefcd7
      -- BufferLineCloseButtonVisible xxx cterm= gui= guifg=#24748a
      -- BufferLineCloseButton xxx cterm= gui= guifg=#24748a
      -- BufferLineTabClose xxx cterm= gui= guifg=#24748a
      -- BufferLineTabSelected xxx cterm= gui= guifg=#a3ace1
      -- BufferLineGroupLabel xxx cterm= gui= guibg=#24748a
      -- BufferLineGroupSeparator xxx cterm= gui= guifg=#24748a
      -- BufferLineInfoSelected xxx cterm=bold,italic gui=bold,italic guifg=#add8e6 guisp=#add8e6
      -- BufferLineErrorDiagnosticVisible xxx cterm= gui= guifg=#1b5767
      -- BufferLineModified xxx cterm= gui= guifg=#c5cdcc
      -- BufferLineFill xxx cterm=
      -- BufferLineNumbersSelected xxx cterm=bold gui=bold guifg=White
      -- BufferLineNumbers xxx cterm= gui= guifg=#7a7c9e
      -- BufferLineSeparator xxx cterm= gui=
      -- BufferLineHint xxx cterm= gui= guifg=#24748a guisp=#d3d3d3
      -- BufferLineTab  xxx cterm= gui= guifg=#24748a
      -- BufferLineWarningDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#bf7b00 guisp=#bf7b00
      -- BufferLineBackground xxx cterm=
      -- BufferLineDiagnostic xxx cterm= gui= guifg=#1b5767
      -- BufferLineOffsetSeparator xxx cterm= gui= guifg=#413893
      -- BufferLinePickVisible xxx cterm=bold,italic gui=bold,italic guifg=#ff0000
      -- BufferLinePickSelected xxx cterm=bold,italic gui=bold,italic guifg=#ff0000
      -- BufferLineIndicatorVisible xxx cterm= gui=
      -- BufferLineIndicatorSelected xxx cterm= gui= guifg=#a3ace1
      -- BufferLineTabSeparatorSelected xxx cterm= gui=
      -- BufferLineTabSeparator xxx cterm= gui=
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
      nvim_set_hl(0, 'MatchWord', { fg = '#7429ff' })
      nvim_set_hl(0, 'MatchBackground', { bg = '#1a1a3b' })
    end,
  })
end

local function lightbulb()
  augroup('lightbulb', { clear = true, })
  autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'lightbulb',
    pattern = '*',
    callback = require('nvim-lightbulb').update_lightbulb,
  })
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
      nvim_set_hl(0, 'SjMatches', { bg = '#36297d', fg = 'white', bold = false, })
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
}
