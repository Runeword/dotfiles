local vim = vim

-- Prevent escape from moving the cursor one character to the left
vim.cmd([[
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
]])

-- vim.api.nvim_create_augroup('quit', { clear = true, })
-- vim.api.nvim_create_autocmd('BufDelete', {
--   group = 'quit',
--   callback = function()
--     local buffers = vim.fn.range(1, vim.fn.bufnr('$'))
--     local listed_buffers = vim.tbl_filter(function(buf)
--       return vim.fn.empty(vim.fn.bufname(buf)) == 0 and vim.fn.buflisted(buf) == 1
--     end, buffers)
--     if #listed_buffers == 1 then
--       vim.cmd('set guicursor=a:ver90')
--       vim.cmd('quit')
--     end
--   end,
--   desc = 'Quit if buffers list is empty',
-- })

vim.api.nvim_create_augroup('cursor', { clear = true, })
vim.api.nvim_create_autocmd('ExitPre', {
  group = 'cursor',
  command = 'set guicursor=a:ver90',
  desc = 'Set cursor back to beam when leaving Neovim',
})

vim.api.nvim_create_augroup('shell', { clear = true, })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'shell',
  pattern = '*.sh',
  command = '!chmod +x %',
  desc = 'Make shell scripts executable after writing',
})

vim.api.nvim_create_augroup('term', { clear = true, })
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'term',
  callback = function()
    vim.o.relativenumber = false
    vim.o.number = false
    vim.cmd('startinsert')
  end,
  desc = 'Disable relative and absolute line numbers, and start insert mode in terminal buffers',
})

vim.api.nvim_create_augroup('view', { clear = true, })
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

vim.api.nvim_create_augroup('help', { clear = true, })
vim.api.nvim_create_autocmd('FileType', {
  group = 'help',
  pattern = 'help',
  callback = function()
    vim.keymap.set('n', 'gx', '<C-]>')
  end,
  desc = 'Use gx instead of <C-]> to follow links for help files',
})

vim.api.nvim_create_augroup('tmux', { clear = true, })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'tmux',
  pattern = '~/.config/tmux/tmux.conf',
  command = 'silent! !tmux source-file ~/.config/tmux/.tmux.conf',
})

vim.api.nvim_create_augroup('disableAutoComment', { clear = true, })
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile', }, {
  group = 'disableAutoComment',
  pattern = '*',
  command = 'setlocal fo-=c fo-=r fo-=o fo+=t',
  desc = 'Disable auto-commenting for all file types',
})

vim.api.nvim_create_augroup('quickfix', { clear = true, })
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
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.schedule(function() vim.cmd('cfirst') end)
  end,
  desc = 'Automatically open the first item in the quickfix window',
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    pcall(vim.keymap.del, 'n', 'grn')
    pcall(vim.keymap.del, { 'n', 'v', }, 'gra')
    pcall(vim.keymap.del, 'n', 'grr')
    pcall(vim.keymap.del, 'n', 'gri')
    pcall(vim.keymap.del, 'n', 'gO')
    pcall(vim.keymap.del, 'i', '<C-s>')
  end,
  desc = 'Remove LSP default global keymaps',
})
