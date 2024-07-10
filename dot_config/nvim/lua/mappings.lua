local vim = vim

----------------------------------- UNMAP

vim.keymap.set('n', '<Enter>', '<Nop>')
vim.keymap.set('n', '<C-n>',   '<Nop>')
vim.keymap.set('n', '<C-p>',   '<Nop>')
vim.keymap.set('',  'Q',       '<Nop>')
vim.keymap.set('',  'q',       '<Nop>')

----------------------------------------------------
-- vim.cmd([[
-- " Close the current buffer, quit vim if it's the last buffer
-- " Pass argument '!" to do so without asking to save
-- function! CloseBufferOrVim(force='')
--   if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
--     exec ("quit" . a:force)
--     quit
--   else
--     exec ("bdelete" . a:force)
--   endif
-- endfunction

-- nnoremap <silent> q :call CloseBufferOrVim('!')<CR>
-- ]])

-- local function close_buffer_or_vim()
--   local listed_buffers = vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)'))

--   if listed_buffers == 1 then
--     vim.cmd('quit' .. '!')
--     vim.cmd('quit')
--   else
--     vim.cmd('bdelete' .. '!')
--   end
-- end

-- Wipe all the active buffers and close all the windows except the current one
local function close_buffer_or_vim()
  local current_window = vim.api.nvim_get_current_win()
  local listed_buffers_count = 0

  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buffer) and vim.api.nvim_buf_get_option(buffer, 'buflisted') then
      listed_buffers_count = listed_buffers_count + 1
    end

    -- If buffer is active
    if vim.fn.bufwinid(buffer) ~= -1 then
      local windows = vim.api.nvim_list_wins()

      for _, window in ipairs(windows) do
        -- If window is not the current one
        if vim.api.nvim_win_is_valid(window) and window ~= current_window then
          local window_buffer = vim.api.nvim_win_get_buf(window)

          -- Delete it's active buffer
          if vim.api.nvim_buf_is_valid(window_buffer) then
            vim.api.nvim_buf_delete(window_buffer, { force = true, })
          end
        end
      end
    end
  end


  if listed_buffers_count == 1 then
    vim.cmd('quit!')
  end
end

-- Set up the keymapping
vim.keymap.set('n', 'q',         close_buffer_or_vim,                                                        { noremap = true, silent = true, })

vim.keymap.set('x', '<C-n>',     ':Norm ')
vim.keymap.set('n', '<Leader>g', '<cmd>silent !google-chrome-stable %:p<CR>')
-- vim.keymap.set('n',           'g<Space>',   '<cmd>silent %s/\\s\\+$//e<CR>')
vim.keymap.set('n', 'g<Space>',  '<cmd>silent s/\\s\\+\\%#\\s*\\|\\s*\\%#\\s\\+/ /g<CR><cmd>nohlsearch<CR>')
-- vim.keymap.set('n',           's',         function() vim.fn.search('\\s\\+\\ze\\s*') end)
-- vim.keymap.set('n',           'S',         function() vim.fn.search('\\s\\+\\ze\\s*', 'b') end)
vim.keymap.set({ 'x', 'n', }, '<Space>',   '<Enter>',      { remap = true, })
vim.keymap.set({ 'x', 'n', }, '<Leader>q', '<cmd>qa!<CR>')
vim.keymap.set({ 'x', 'n', }, 'Q',         '<cmd>qa!<CR>')

-- vim.keymap.set('n',           '<Leader>ti',      '<cmd>Inspect<CR>')
-- vim.keymap.set('n',           '<Leader>tt',      '<cmd>InspectTree<CR>')
-- vim.keymap.set('n',           '<Leader>tq',      '<cmd>PreviewQuery<CR>')

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
vim.keymap.set('n', '<C-R>', "<cmd>exec 'undo' undotree()['seq_last']<CR>")

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

----------------------------------- WINDOW

vim.keymap.set({ 'n', 'x', }, '<C-Down>',  '<C-w>j')
vim.keymap.set({ 'n', 'x', }, '<C-Up>',    '<C-w>k')
vim.keymap.set({ 'n', 'x', }, '<C-Left>',  '<C-w>h')
vim.keymap.set({ 'n', 'x', }, '<C-Right>', '<C-w>l')
-- vim.keymap.set({ 'n', 'x', }, '<Tab>',     '<C-w>w')
-- vim.keymap.set({ 'n', 'x', }, '<S-Tab>',   '<C-w>W')

-- vim.keymap.set({ 'n', 'x', }, '<C-Down>',
--   function()
--     local key = vim.api.nvim_replace_termcodes('<C-w>', true, false, true)
--     vim.api.nvim_feedkeys(key .. 'w', 'j', false)
--   end)

-- ----------------------------------- treesitter text object hook

-- local ts = vim.treesitter
-- local api = vim.api

-- -- Function to get the node at cursor
-- local function get_node_at_cursor()
--   local bufnr = api.nvim_get_current_buf()
--   local row, col = unpack(api.nvim_win_get_cursor(0))
--   row = row - 1 -- API uses 0-based rows

--   local parser = ts.get_parser(bufnr)
--   if not parser then return end

--   local root = parser:parse()[1]:root()
--   return root:named_descendant_for_range(row, col, row, col)
-- end

-- -- Function to check if cursor is on a specific text object
-- local function is_cursor_on_text_object(object_type)
--   local node = get_node_at_cursor()
--   if not node then return false end

--   return node:type() == object_type
-- end

-- -- Function to print message when cursor is on specific text object
-- local function print_message_on_text_object(object_type, message)
--   if is_cursor_on_text_object(object_type) then
--     print(message)
--   end
-- end

-- -- Function to attach a mapping when cursor is on specific text object
-- local function attach_mapping_on_text_object(object_type, mode, lhs, rhs, opts)
--   if is_cursor_on_text_object(object_type) then
--     local buffer = api.nvim_get_current_buf()
--     opts = opts or { noremap = true, silent = true, buffer = buffer, }
--     api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
--   else
--     -- Remove the mapping if it exists and we're not on the text object
--     pcall(api.nvim_buf_del_keymap, api.nvim_get_current_buf(), mode, lhs)
--   end
-- end

-- -- Set up an autocommand to check cursor position
-- api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', }, {
--   pattern = '*',
--   callback = function()
--     -- Example: Print message when cursor is on a function declaration
--     print_message_on_text_object('function_declaration', 'Cursor is on a function declaration!')
--     attach_mapping_on_text_object(
--       'function_declaration',
--       'n',
--       '<leader>f',
--       ":echo 'Function action'<CR>",
--       { desc = 'Perform action on function', }
--     )

--     -- You can add more checks for different text objects here
--     -- For example:
--     -- print_message_on_text_object("if_statement", "Cursor is on an if statement!")
--     -- print_message_on_text_object("variable_declaration", "Cursor is on a variable declaration!")
--   end,
-- })

----------------------------------- EDIT

vim.keymap.set('i', '<C-BS>', '<Esc>cvb')
vim.keymap.set('n', '<BS>',   '`[v`]')

-- When the line is empty, move the cursor to the beginning of the line
vim.keymap.set('n', 'i', function()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true, })

-- vim.cmd([[
-- nnoremap <expr> gh '`[' . strpart(getregtype(), 0, 1) . '`]'
-- ]])

-- vim.keymap.set('n', '<BS>', '"_ciw')

----------------------------------- TEXT OBJECTS

vim.keymap.set({ 'o', 'x', }, 'a<Space>', 'ap')
vim.keymap.set({ 'o', 'x', }, 'i<Space>', 'ip')
vim.keymap.set({ 'o', 'x', }, '<Space>',  'ip')
vim.keymap.set({ 'o', 'x', }, 'a<Enter>', 'ap')
vim.keymap.set({ 'o', 'x', }, 'i<Enter>', 'ip')
vim.keymap.set({ 'o', },      '<Enter>',  'ip')

vim.keymap.set({ 'o', 'x', }, 'q',        'iq', { remap = true, })
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
vim.keymap.set('x',           'v',  'V')

-- vim.keymap.set('n',           'V',  'mz$v`z<cmd>delmarks z<CR>')
vim.keymap.set('n', 'V', function()
  local current_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { current_pos[1], #vim.api.nvim_get_current_line(), })
  vim.api.nvim_feedkeys('v', 'nx', false)
  vim.api.nvim_win_set_cursor(0, current_pos)
end)

----------------------------------- READLINE

vim.keymap.set('i', '<C-a>', '<esc>I')
vim.keymap.set('i', '<C-e>', '<end>')
vim.keymap.set('i', '<C-k>', '<esc>ld$i')
vim.keymap.set('i', '<C-H>', '<C-w>')

--------------------------------- MOTIONS

vim.keymap.set({ 'x', 'n', }, 'k', 'gk')
vim.keymap.set({ 'x', 'n', }, 'j', 'gj')
-- vim.keymap.set({ 'x', 'n', }, 'K',     '4kg^')
-- vim.keymap.set({ 'x', 'n', }, 'J',     '4jg^')

-- vim.keymap.set('n', 'J', function()
--     vim.cmd('/\\v\\S')
--     vim.cmd('norm! 4jg^')
-- end, { noremap = true })

-- vim.keymap.set({'x', 'n', }, 'K', function()
--     vim.cmd('?\\v^\\S')
--     vim.cmd('norm! 4kg^')
-- end, { noremap = true })

local function move_to_non_empty_line(lines)
  local new_line

  if lines > 0 then
    local nextParagraphStart = vim.fn.search([[\(^$\n\s*\zs\S\)\|\(\S\ze\n*\%$\)]], 'nW')
    local nextNonBlank = vim.fn.nextnonblank(vim.fn.line('.') + lines)
    new_line = nextNonBlank < nextParagraphStart and nextNonBlank or nextParagraphStart
  else
    local prevParagraphStart = vim.fn.search([[\(^$\n\s*\zs\S\)\|\(^\%1l\s*\zs\S\)]], 'nWb')
    local prevNonBlank = vim.fn.prevnonblank(vim.fn.line('.') + lines)
    new_line = prevNonBlank > prevParagraphStart and prevNonBlank or prevParagraphStart
  end

  -- Move the cursor to the first non-blank character of the line
  vim.fn.cursor(new_line, vim.fn.getline(new_line):find('%S') or 1)
end

vim.keymap.set({ 'x', 'n', }, 'K', function() move_to_non_empty_line(-4) end, { noremap = true, })
vim.keymap.set({ 'x', 'n', }, 'J', function() move_to_non_empty_line(4) end,  { noremap = true, })

-- vim.cmd([[
-- nnoremap J :<C-u>call search('^.\+')<CR>
-- nnoremap K :<C-u>call search('^.\+', 'b')<CR>
-- ]])

vim.keymap.set({ 'x', 'n', }, '<C-j>', 'J')
vim.keymap.set('n',           '0',     'g0')

vim.keymap.set('n', '$', function()
  vim.fn.execute('normal! g$')
  vim.o.ve = ''
  vim.o.ve = 'all'
end)

vim.keymap.set('n', '^', 'g^')
vim.keymap.set('n', '&', 'g^')

-- vim.keymap.set({ 'n', 'x', }, '<Space>', function() vim.fn.search('\\s\\+', 'W') end)
-- vim.keymap.set({ 'n', 'x', }, '<Space>', function() vim.fn.search('\\s\\+', 'bW') end)
vim.keymap.set({ 'n', 'x', }, ',',  function() vim.fn.search('[,.:;]') end)
vim.keymap.set({ 'n', 'x', }, '<',  function() vim.fn.search('[,.:;]', 'b') end)
vim.keymap.set({ 'n', },      '\'', function() vim.fn.search('[\'"`]') end)
vim.keymap.set({ 'n', },      '"',  function() vim.fn.search('[\'"`]', 'b') end)
vim.keymap.set({ 'n', 'x', }, ')',  function() vim.fn.search(')') end)
vim.keymap.set({ 'n', 'x', }, '(',  function() vim.fn.search('(') end)
-- vim.keymap.set({ 'n', 'x', }, '<Tab>',   function() vim.fn.search('[([{]') end)
-- vim.keymap.set({ 'n', 'x', }, '<S-Tab>', function() vim.fn.search('[([{]', 'b') end)

---------------------------------- folke/lazy.nvim

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>')
