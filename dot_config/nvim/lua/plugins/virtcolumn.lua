local vim = vim

return {
  'lukas-reineke/virt-column.nvim',
  enabled = true,

  config = function()
    require('virt-column').setup({
      char = '',
      highlight = 'virtcolumn',
    })

    vim.o.colorcolumn = '80'
  end,
}
