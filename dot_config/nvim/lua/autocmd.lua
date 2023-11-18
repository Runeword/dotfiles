local vim = vim
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup('chezmoi',            { clear = true, })
augroup('help',               { clear = true, })
augroup('tmux',               { clear = true, })
augroup('diagnostic',         { clear = true, })
augroup('quickfix',           { clear = true, })
augroup('disableAutoComment', { clear = true, })
augroup('term',               { clear = true, })
augroup('view',               { clear = true, })
augroup('cursor',             { clear = true, })

-- Prevent escape from moving the cursor one character to the left
vim.cmd([[
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
]])

vim.api.nvim_create_autocmd('ExitPre', {
  group = 'cursor',
  command = 'set guicursor=a:ver90',
  desc = 'Set cursor back to beam when leaving Neovim',
})

autocmd('TermOpen', {
  group = 'term',
  callback = function()
    vim.o.relativenumber = false
    vim.o.number = false
    vim.cmd('startinsert')
  end,
  desc = 'Disable relative and absolute line numbers, and start insert mode in terminal buffers',
})

autocmd({ 'BufWinLeave', }, {
  group = 'view',
  pattern = '*.*',
  command = 'mkview',
  desc = 'Save cursor position and folds when leaving a buffer',
})

autocmd({ 'BufWinEnter', }, {
  group = 'view',
  pattern = '*.*',
  command = 'silent! loadview',
  desc = 'Restore cursor position and folds when entering a buffer',
})

autocmd('BufWritePost', {
  group = 'chezmoi',
  pattern = '~/.local/share/chezmoi/*',
  command = 'silent! !chezmoi apply --source-path %',
})

autocmd('FileType', {
  group = 'help',
  pattern = 'help',
  callback = function()
    vim.keymap.set('n', 'gx', '<C-]>')
  end,
  desc = 'Use gx instead of <C-]> to follow links for help files',
})

autocmd('BufWritePost', {
  group = 'tmux',
  pattern = '~/.config/tmux/tmux.conf',
  command = 'silent! !tmux source-file ~/.config/tmux/.tmux.conf',
})

autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile', }, {
  group = 'disableAutoComment',
  pattern = '*',
  command = 'setlocal fo-=c fo-=r fo-=o fo+=t',
  desc = 'Disable auto-commenting for all file types',
})

autocmd('FileType', {
  group = 'quickfix',
  pattern = 'qf',
  command = 'set nobuflisted',
  desc = 'Exclude quickfix buffer from the buffer list',
})

autocmd('FileType', {
  group = 'quickfix',
  pattern = 'qf',
  callback = function()
    vim.cmd(math.max(math.min(vim.fn.line('$'), 10), 3) ..
      'wincmd _')
  end,
  desc = 'Automatically fitting a quickfix window to 10 lines max and 3 lines min height',
})

vim.api.nvim_create_autocmd('colorscheme', {
  group = 'diagnostic',
  pattern = '*',
  callback = function()
    -- #0a172e #10141f #1a1a3b #1e2633 #424a57 #7a7c9e #222b66

    vim.api.nvim_set_hl(0, 'diagnosticerror',          { bg = 'NONE', fg = '#ff75a9', bold = false, italic = true, })
    vim.api.nvim_set_hl(0, 'diagnosticunderlineerror', { bg = 'NONE', undercurl = true, sp = '#ff75a9', })

    vim.api.nvim_set_hl(0, 'diagnosticfloatingerror',  { link = 'normal', })
    -- vim.api.nvim_set_hl(0, 'diagnosticfloatingerror',  { link = 'diagnosticvirtualtexterror', })
    -- vim.api.nvim_set_hl(0, 'diagnosticfloatinghint',   { link = 'diagnosticvirtualtexthint', })
    -- vim.api.nvim_set_hl(0, 'diagnosticfloatinginfo',   { link = 'diagnosticvirtualtextinfo', })
    -- vim.api.nvim_set_hl(0, 'diagnosticfloatingwarn',   { link = 'diagnosticvirtualtextwarn', })

    vim.api.nvim_set_hl(0, 'normalfloat',  { bg = '#1e2633', })
    vim.api.nvim_set_hl(0, 'floatborder',  { bg = '#1e2633', fg = '#1e2633', })

    vim.api.nvim_set_hl(0, 'pmenu',        { bg = 'black', fg = '#7a7c9e', })
    vim.api.nvim_set_hl(0, 'pmenusel',     { bg = '#1e2633', fg = 'white', })
    vim.api.nvim_set_hl(0, 'pmenusbar',    { bg = 'black', })
    vim.api.nvim_set_hl(0, 'pmenuthumb',   { bg = '#1e2633', })

    vim.api.nvim_set_hl(0, 'linenr',       { bg = 'none', fg = '#4b586e', })
    vim.api.nvim_set_hl(0, 'cursorlinenr', { bg = 'none', fg = 'white', })
    vim.api.nvim_set_hl(0, 'cursorline',   { bg = 'none', })
    vim.api.nvim_set_hl(0, 'cursorcolumn', { bg = '#1e2633', })

    vim.api.nvim_set_hl(0, 'search',       { bg = '#5d00ff', })
    vim.api.nvim_set_hl(0, 'incsearch',    { bg = '#faff00', fg = 'black', })
    vim.api.nvim_set_hl(0, 'normal',       { bg = 'none', })

    vim.api.nvim_set_hl(0, 'signcolumn',   { bg = 'none', })
    vim.api.nvim_set_hl(0, 'foldcolumn',   { bg = 'none', })
    vim.api.nvim_set_hl(0, 'folded',       { bg = 'none', })

    vim.api.nvim_set_hl(0, 'nontext',      { bg = 'none', fg = '#384354', })
    vim.api.nvim_set_hl(0, 'whitespace',   { bg = 'none', fg = '#384354', })
  end,
})
