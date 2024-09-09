local vim = vim

return {
  enabled = true,

  'chrisgrieser/nvim-spider',

  config = function()
    vim.keymap.set({ 'n', 'x', }, 'W',
    function()
      require('spider').motion('w', {
        customPatterns = {
          -- Match one or more characters that are neither word characters nor whitespace characters
          '[^%w%s]+',
        },
      })
    end, {})

    vim.keymap.set({ 'n', 'x', }, 'w',
      function()
        require('spider').motion('w', {
          customPatterns = {
            -- subwordPatterns
            '%w+',
            '%u%l+',
            -- skipPunctuationPatterns
            '%f[^%s]%p+%f[%s]',
            '^%p+%f[%s]',
            '%f[^%s]%p+$',
            '^%p+$',
          },
        })
      end, { desc = 'Spider-w', })

    vim.keymap.set({ 'n', 'x', }, 'b',
      function()
        require('spider').motion('b', {
          customPatterns = {
            -- subwordPatterns
            '%w+',
            '%l%u+',
            -- skipPunctuationPatterns
            '%f[^%s]%p+%f[%s]',
            '^%p+%f[%s]',
            '%f[^%s]%p+$',
            '^%p+$',
          },
        })
      end, { desc = 'Spider-b', })

    -- vim.keymap.set({ 'n', 'x', }, 'w',
    --   "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w', })
    -- vim.keymap.set({ 'n', 'x', }, 'b',
    --   "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b', })
    vim.keymap.set({ 'n', 'x', 'o', }, 'e',
      "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e', })
    vim.keymap.set({ 'n', 'x', 'o', }, 'ge',
      "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge', })

    vim.keymap.set({ 'o', }, 'w', 'iw')
    vim.keymap.set({ 'o', }, 'W', 'iW')

    -- vim.keymap.set({ 'n', }, 'e',  "<CMD>call search('\\>')<CR>",      { silent = true, noremap = true, })
    -- vim.keymap.set({ 'n', }, 'ge', "<CMD>call search('\\>', 'b')<CR>", { silent = true, noremap = true, })
  end,
}
