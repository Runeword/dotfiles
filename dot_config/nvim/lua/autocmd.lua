local vim = vim

vim.api.nvim_create_augroup('chezmoi',            { clear = true, })
vim.api.nvim_create_augroup('help',               { clear = true, })
vim.api.nvim_create_augroup('tmux',               { clear = true, })
vim.api.nvim_create_augroup('diagnostic',         { clear = true, })
vim.api.nvim_create_augroup('quickfix',           { clear = true, })
vim.api.nvim_create_augroup('disableAutoComment', { clear = true, })
vim.api.nvim_create_augroup('term',               { clear = true, })
vim.api.nvim_create_augroup('view',               { clear = true, })
vim.api.nvim_create_augroup('cursor',             { clear = true, })
-- vim.api.nvim_create_augroup('write',              { clear = true, })

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

vim.api.nvim_create_autocmd('TermOpen', {
  group = 'term',
  callback = function()
    vim.o.relativenumber = false
    vim.o.number = false
    vim.cmd('startinsert')
  end,
  desc = 'Disable relative and absolute line numbers, and start insert mode in terminal buffers',
})

vim.api.nvim_create_autocmd({ 'BufWinLeave', }, {
  group = 'view',
  pattern = '*.*',
  command = 'mkview',
  desc = 'Save cursor position and folds when leaving a buffer',
})

vim.api.nvim_create_autocmd({ 'BufWinEnter', }, {
  group = 'view',
  pattern = '*.*',
  command = 'silent! loadview',
  desc = 'Restore cursor position and folds when entering a buffer',
})

-- vim.api.nvim_create_autocmd('BufWriteCmd', {
--   group = 'write',
--   pattern = '*',
--   nested = true,
--   callback = function()
--     local start = vim.fn.getpos("'[")
--     local finish = vim.fn.getpos("']")
--     vim.api.nvim_buf_set_var(0, 'start', start)
--     vim.api.nvim_buf_set_var(0, 'finish', finish)
--     vim.print(start)
--     vim.print(finish)
--     vim.print(finish)
--   end,
-- })

-- vim.api.nvim_create_autocmd('BufWritePost', {
--   group = 'write',
--   pattern = '*',
--   nested = true,
--   callback = function()
--     local start = vim.api.nvim_buf_get_var(0, 'start')
--     local finish = vim.api.nvim_buf_get_var(0, 'finish')
--     vim.fn.setpos("'[", start)
--     vim.fn.setpos("']", finish)
--     vim.print(start)
--     vim.print(finish)
--   end,
-- })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'chezmoi',
  pattern = '~/.local/share/chezmoi/*',
  command = 'silent! !chezmoi apply --source-path %',
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'help',
  pattern = 'help',
  callback = function()
    vim.keymap.set('n', 'gx', '<C-]>')
  end,
  desc = 'Use gx instead of <C-]> to follow links for help files',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'tmux',
  pattern = '~/.config/tmux/tmux.conf',
  command = 'silent! !tmux source-file ~/.config/tmux/.tmux.conf',
})

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile', }, {
  group = 'disableAutoComment',
  pattern = '*',
  command = 'setlocal fo-=c fo-=r fo-=o fo+=t',
  desc = 'Disable auto-commenting for all file types',
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'quickfix',
  pattern = 'qf',
  command = 'set nobuflisted',
  desc = 'Exclude quickfix buffer from the buffer list',
})

vim.api.nvim_create_autocmd('FileType', {
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

    vim.api.nvim_set_hl(0, 'DiagnosticError',          { bg = 'NONE', fg = '#ff75a9', bold = false, italic = true, })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { bg = 'NONE', undercurl = true, sp = '#ff75a9', })
    vim.api.nvim_set_hl(0, 'diagnosticWarn',          { bg = 'NONE', fg = '#ff9d57', bold = false, italic = true, })
    vim.api.nvim_set_hl(0, 'diagnosticUnderlineWarn', { bg = 'NONE', undercurl = true, sp = '#ff9d57', })
    vim.api.nvim_set_hl(0, 'diagnosticInfo',          { bg = 'NONE', fg = '#a6c8ff', bold = false, italic = true, })
    vim.api.nvim_set_hl(0, 'diagnosticUnderlineInfo', { bg = 'NONE', undercurl = true, sp = '#a6c8ff', })
    vim.api.nvim_set_hl(0, 'diagnosticHint',          { bg = 'NONE', fg = '#adb5bd', bold = false, italic = true, })
    vim.api.nvim_set_hl(0, 'diagnosticUnderlineHint', { bg = 'NONE', undercurl = true, sp = '#adb5bd', })
    vim.api.nvim_set_hl(0, 'diagnosticUnnecessary', { bg = 'NONE', undercurl = true, sp = '#adb5bd', })

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
