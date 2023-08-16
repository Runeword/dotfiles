local vim = vim
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup('chezmoi', { clear = true, })
augroup('help', { clear = true, })
augroup('tmux', { clear = true, })
augroup('diagnostic', { clear = true, })
augroup('quickfix', { clear = true, })
augroup('disableAutoComment', { clear = true, })
augroup('term', { clear = true, })
augroup('view', { clear = true, })

autocmd('TermOpen', {
  group = 'term',
  callback = function()
    vim.o.relativenumber = false
    vim.o.number = false
    vim.cmd('startinsert')
  end,
})

autocmd({ 'BufWinLeave', }, {
  group = 'view',
  pattern = '*.*',
  command = 'mkview',
})

autocmd({ 'BufWinEnter', }, {
  group = 'view',
  pattern = '*.*',
  command = 'silent! loadview',
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
    vim.cmd(math.max(math.min(vim.fn.line('$'), 10), 3) ..
      'wincmd _')
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'diagnostic',
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingError',
      { link = 'DiagnosticVirtualTextError', })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint',
      { link = 'DiagnosticVirtualTextHint', })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo',
      { link = 'DiagnosticVirtualTextInfo', })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn',
      { link = 'DiagnosticVirtualTextWarn', })

    -- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { bg = 'none', undercurl = true})
    -- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { bg = 'none', undercurl = true})
    -- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { bg = 'none', undercurl = true})
    -- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { bg = 'none', undercurl = true})
    -- vim.api.nvim_set_hl(0, 'DiagnosticUnderlineOk', { bg = 'none', undercurl = true})

    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none', })
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = '#1e2633', })

    vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'black', fg = '#7a7c9e', })
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#1e2633', fg = 'white', })
    vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = 'black', })
    vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#1e2633', })

    -- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1e2633', })
    vim.api.nvim_set_hl(0, 'CursorColumn', { bg = '#1e2633', })

    vim.api.nvim_set_hl(0, 'Search', { bg = '#5d00ff', })
    vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#FAFF00', fg = 'black', })
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', })

    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none', })
    -- vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'none', })
    vim.api.nvim_set_hl(0, 'Folded', { bg = 'none', })

    vim.api.nvim_set_hl(0, 'NonText', { bg = 'none', fg = '#45608c', })
    vim.api.nvim_set_hl(0, 'Whitespace', { bg = 'none', fg = '#45608c', })

    -- vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#292e42' })
    -- vim.api.nvim_set_hl(0, 'Hlargs', { fg = '#FAFF00' })

    -- #0a172e #1e2633 '#424a57' #7a7c9e #222b66
  end,
})
