local vim = vim
return {
  'robitx/gp.nvim',

  enabled = false,

  config = function()
    require('gp').setup({
      openai_api_key = { 'pass', 'show', 'OPENAI_API_KEY', },
      -- toggle_target = 'popup',

      providers = {
        openai = {},
        googleai = { disabled = false, secret = { 'pass', 'show', 'GEMINI_API_KEY', }, },
      },

      -- chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x', }, shortcut = '<Leader><Leader>', },
      -- chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x', }, shortcut = '<C-g>d', },
      -- chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x', }, shortcut = '<C-g>s', },
      -- chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x', }, shortcut = '<C-g>c', },
    })

    local function keymapOptions(desc)
      return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = 'GPT prompt ' .. desc,
      }
    end

    vim.keymap.set({ 'n', }, '<Leader>n', '<cmd>GpChatNew<cr>', keymapOptions('New Chat'))
    -- vim.keymap.set('v', '<Leader>n', ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions('Visual Chat Paste'))

    -- vim.keymap.set({ 'n', 'i', }, '<C-g>c', '<cmd>GpChatNew<cr>', keymapOptions('New Chat'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>t', '<cmd>GpChatToggle<cr>', keymapOptions('Toggle Chat'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>f', '<cmd>GpChatFinder<cr>', keymapOptions('Chat Finder'))

    -- vim.keymap.set('v', '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", keymapOptions('Visual Chat New'))
    -- vim.keymap.set('v', '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions('Visual Chat Paste'))
    -- vim.keymap.set('v', '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions('Visual Toggle Chat'))

    -- vim.keymap.set({ 'n', 'i', }, '<C-g><C-x>', '<cmd>GpChatNew split<cr>', keymapOptions('New Chat split'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', keymapOptions('New Chat vsplit'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', keymapOptions('New Chat tabnew'))

    -- vim.keymap.set('v', '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions('Visual Chat New split'))
    -- vim.keymap.set('v', '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions('Visual Chat New vsplit'))
    -- vim.keymap.set('v', '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions('Visual Chat New tabnew'))

    -- -- Prompt commands
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>r', '<cmd>GpRewrite<cr>', keymapOptions('Inline Rewrite'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>a', '<cmd>GpAppend<cr>', keymapOptions('Append (after)'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>b', '<cmd>GpPrepend<cr>', keymapOptions('Prepend (before)'))

    -- vim.keymap.set('v', '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", keymapOptions('Visual Rewrite'))
    -- vim.keymap.set('v', '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", keymapOptions('Visual Append (after)'))
    -- vim.keymap.set('v', '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", keymapOptions('Visual Prepend (before)'))
    -- vim.keymap.set('v', '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", keymapOptions('Implement selection'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>gp', '<cmd>GpPopup<cr>', keymapOptions('Popup'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>ge', '<cmd>GpEnew<cr>', keymapOptions('GpEnew'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>gn', '<cmd>GpNew<cr>', keymapOptions('GpNew'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>gv', '<cmd>GpVnew<cr>', keymapOptions('GpVnew'))
    -- vim.keymap.set({ 'n', 'i', }, '<C-g>gt', '<cmd>GpTabnew<cr>', keymapOptions('GpTabnew'))

    -- vim.keymap.set('v', '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", keymapOptions('Visual Popup'))
    -- vim.keymap.set('v', '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", keymapOptions('Visual GpEnew'))
    -- vim.keymap.set('v', '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", keymapOptions('Visual GpNew'))
    -- vim.keymap.set('v', '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", keymapOptions('Visual GpVnew'))
    -- vim.keymap.set('v', '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", keymapOptions('Visual GpTabnew'))

    -- vim.keymap.set({ 'n', 'i', }, '<C-g>x', '<cmd>GpContext<cr>', keymapOptions('Toggle Context'))
    -- vim.keymap.set('v', '<C-g>x', ":<C-u>'<,'>GpContext<cr>", keymapOptions('Visual Toggle Context'))

    -- vim.keymap.set({ 'n', 'i', 'v', 'x', }, '<C-g>s', '<cmd>GpStop<cr>', keymapOptions('Stop'))
    -- vim.keymap.set({ 'n', 'i', 'v', 'x', }, '<C-g>n', '<cmd>GpNextAgent<cr>', keymapOptions('Next Agent'))
  end,
}
