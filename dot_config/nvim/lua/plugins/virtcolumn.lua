local vim = vim

return {
  'lukas-reineke/virt-column.nvim',
  enabled = true,

  config = function()
    require('virt-column').setup({
      char = '▏',
    })
    vim.o.colorcolumn = '80'
  end,
}
