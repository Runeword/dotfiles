local vim = vim

vim.keymap.set('x',           '<C-n>',      ':Norm ')
vim.keymap.set('n',           '<Leader>g',  '<cmd>silent !google-chrome-stable %:p<CR>')
vim.keymap.set('n',           'g<Space>',   '<cmd>silent %s/\\s\\+$//e<CR>')
vim.keymap.set({ 'x', 'n', }, '<Space>',    '<Enter>',                                   { remap = true, })

vim.keymap.set('n',           '<Leader>ti', '<cmd>Inspect<CR>')
vim.keymap.set('n',           '<Leader>tt', '<cmd>InspectTree<CR>')
vim.keymap.set('n',           '<Leader>tq', '<cmd>PreviewQuery<CR>')

-- Display messages in a floating window
local function displayMessages()
  local messages_string = vim.fn.split(vim.api.nvim_exec2('silent messages', { output = true, }).output, '\n')
  if next(messages_string) == nil then return end

  local buffer_id = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buffer_id, 'messages')

  vim.api.nvim_buf_set_lines(buffer_id, 0, -1, false, messages_string)

  local width = 80
  local height = #messages_string

  local window_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
  }

  vim.api.nvim_set_option_value('modifiable', false, { buf = buffer_id, })
  vim.api.nvim_open_win(buffer_id, true, window_opts)
end

vim.keymap.set('n', '<Leader>m', displayMessages, { noremap = true, silent = true, })

----------------------------------- SAVE

-- vim.keymap.set('n', '<C-s>',     '<cmd>silent write<CR>')
-- vim.keymap.set('i', '<C-s>',     '<Esc>`^<cmd>silent write<CR>')
-- vim.keymap.set('x', '<C-s>',     '<Esc><cmd>silent write<CR>')
-- vim.keymap.set('x', 'gs', '<Esc><cmd>silent write<CR>')
-- vim.keymap.set('n', 'gs', '<cmd>silent write<CR>')

-- Write while keeping last changes position
vim.keymap.set('n', 'gs', function()
  local start = vim.fn.getpos("'[")
  local finish = vim.fn.getpos("']")

  vim.cmd('silent! write')

  vim.fn.setpos("'[", start)
  vim.fn.setpos("']", finish)
end)

----------------------------------- UNDO / REDO

-- Undo all changes
vim.keymap.set('n', 'U', '<cmd>u0<CR>')

-- Redo all changes
vim.keymap.set('n', 'R', "<cmd>exec 'undo' undotree()['seq_last']<CR>")

-- Delete undo tree
vim.keymap.set('n', '<Leader>s', function()
  local start = vim.fn.getpos("'[")
  local finish = vim.fn.getpos("']")

  local view = vim.fn.winsaveview()
  vim.o.undoreload = 0
  vim.cmd('edit')
  vim.fn.winrestview(view)

  vim.fn.setpos("'[", start)
  vim.fn.setpos("']", finish)
end, { silent = true, })

----------------------------------- EDIT

-- When the line is empty, move the cursor to the beginning of the line
vim.keymap.set('n', 'i', function()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true, })

----------------------------------- FOLD

-- vim.keymap.set('n', 'g<Tab>', 'za')

-- Toggle fold
local isFolded = false
vim.keymap.set('n', 'g<Enter>', function()
  if not isFolded then
    vim.api.nvim_feedkeys('zR', 'n', false)
    isFolded = true
  else
    vim.api.nvim_feedkeys('zM', 'n', false)
    isFolded = false
  end
end)

----------------------------------- ESC

-- vim.keymap.set('n', '<Leader>t', '<cmd>te<CR>')
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

vim.keymap.set('n', '<Esc>',
  function()
    -- Quit diagnostic window
    local buffer_id = vim.fn.bufnr('diagnostic_message')
    if buffer_id ~= -1 then
      vim.api.nvim_buf_delete(buffer_id, { force = true, unload = false, })
    end

    -- Quit messages window
    local bff = vim.fn.bufnr('messages')
    if bff ~= -1 then
      vim.api.nvim_buf_delete(bff, { force = true, unload = false, })
    end

    -- Move cursor to the beginning of the line
    vim.api.nvim_feedkeys(string.format('%c%s', 27, 'g^'), 'n', true) -- <Esc>g^
  end
)

----------------------------------- UNMAP

-- vim.keymap.set('n', '<Enter>', '<Nop>')
vim.keymap.set('n', '<C-n>', '<Nop>')
vim.keymap.set('n', '<C-p>', '<Nop>')
vim.keymap.set('',  'Q',     '<Nop>')
vim.keymap.set('',  'q',     '<Nop>')

----------------------------------- EDIT

vim.keymap.set('i', '<C-BS>', '<Esc>cvb')

vim.keymap.set('n', '<BS>',   '`[v`]')
-- vim.cmd([[
-- nnoremap <expr> gh '`[' . strpart(getregtype(), 0, 1) . '`]'
-- ]])

-- vim.keymap.set('n', '<BS>', '"_ciw')

----------------------------------- TEXT OBJECTS

vim.keymap.set({ 'o', 'x', }, 'a<Space>', 'ap', { remap = true, })
vim.keymap.set({ 'o', 'x', }, 'i<Space>', 'ip')
vim.keymap.set({ 'o', },      '<Space>',  'ip')
vim.keymap.set({ 'o', 'x', }, 'a<Enter>', 'ap')
vim.keymap.set({ 'o', 'x', }, 'i<Enter>', 'ip')
vim.keymap.set({ 'o', },      '<Enter>',  'ip')

vim.keymap.set({ 'x', 'o', }, 'q',        'iq')
vim.keymap.set({ 'o', },      'b',        'ib')
vim.keymap.set({ 'o', },      'w',        'iw')
vim.keymap.set({ 'o', },      '(',        'i(')
vim.keymap.set({ 'o', },      ')',        'i)')
vim.keymap.set({ 'o', },      '[',        'i[')
vim.keymap.set({ 'o', },      ']',        'i]')
vim.keymap.set({ 'o', },      '{',        'i{')
vim.keymap.set({ 'o', },      '}',        'i}')
vim.keymap.set({ 'o', },      '<',        'i<')
vim.keymap.set({ 'o', },      '>',        'i>')

-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:()', 'i(', { remap = true, })
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:))', 'a)', { remap = true, })
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:{)', 'i{', { remap = true, })
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:})', 'a}', { remap = true, })
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:[)', 'i[', { remap = true, })
-- vim.keymap.set({ 'x', 'o' }, '<Plug>(arpeggio-default:])', 'a]', { remap = true, })
-- vim.fn['arpeggio#map']('ox', '', 0, '()', 'a)')
-- vim.fn['arpeggio#map']('ox', '', 0, '{}', 'a}')
-- vim.fn['arpeggio#map']('ox', '', 0, '[]', 'a]')

----------------------------------- OPERATORS

-- vim.keymap.set('x', 'p', '"_dP')
vim.keymap.set({ 'n', 'v', }, 'd',  '"_d')
vim.keymap.set('n',           'D',  '"_D')
vim.keymap.set('n',           'dd', '"_dd^')
vim.keymap.set({ 'n', 'v', }, 'x',  '"_x')
vim.keymap.set({ 'n', 'v', }, 'm',  'd')
vim.keymap.set('n',           'M',  'D')
vim.keymap.set('n',           'mm', 'dd^')

----------------------------------- READLINE

vim.keymap.set('i', '<C-a>', '<esc>I')
vim.keymap.set('i', '<C-e>', '<end>')
vim.keymap.set('i', '<C-k>', '<esc>ld$i')
vim.keymap.set('i', '<C-H>', '<C-w>')

--------------------------------- MOTIONS

vim.keymap.set({ 'x', 'n', }, 'k',        'gk')
vim.keymap.set({ 'x', 'n', }, 'j',        'gj')
vim.keymap.set({ 'x', 'n', }, '<S-Down>', '4jg^')
vim.keymap.set({ 'x', 'n', }, '<S-Up>',   '4kg^')

-- vim.cmd([[
-- nnoremap J :<C-u>call search('^.\+')<CR>
-- nnoremap K :<C-u>call search('^.\+', 'b')<CR>
-- ]])

vim.keymap.set('n', '0', 'g0')

vim.keymap.set('n', '$', function()
  vim.fn.execute('normal! g$')
  vim.o.ve = ''
  vim.o.ve = 'all'
end)

vim.keymap.set('n', '^', 'g^')
vim.keymap.set('n', '&', 'g^')

-- vim.keymap.set({ 'n', 'x', }, '<Space>', function() vim.fn.search('\\s\\+', 'W') end)
-- vim.keymap.set({ 'n', 'x', }, '<Space>', function() vim.fn.search('\\s\\+', 'bW') end)
vim.keymap.set({ 'n', 'x', }, '(',     function() vim.fn.search('[([{]') end)
vim.keymap.set({ 'n', 'x', }, ')',     function() vim.fn.search('[([{]', 'b') end)

vim.keymap.set('n',           '<C-i>', '<C-i>',                                    { silent = true, })
-- vim.keymap.set('n', '<PageUp>', '<C-i>')
-- vim.keymap.set('n', '<PageDown>', '<C-o>')

---------------------------------- BUFFERS

vim.keymap.set({ 'n', 'x', }, '<Leader>q', '<cmd>qa!<CR>')
vim.keymap.set('n',           '<C-w>',     '<cmd>silent bwipeout!<CR>')
vim.keymap.set('n',           '<C-t>',     '<cmd>silent enew<CR>')
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, })
-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, })

---------------------------------- folke/lazy.nvim

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
