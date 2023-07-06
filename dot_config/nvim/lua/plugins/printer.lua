local vim = vim

return {
  'rareitems/printer.nvim',

  config = function()
    require('printer').setup({
      keymap = '<Leader>p',

      formatters = {
        typescript = function(text_inside, text_var)
          return string.format("console.log('%s ', %s)", text_inside, text_var)
        end,
      },

      add_to_inside = function(text)
        return string.format('(%s) %s', vim.fn.line('.'), text)
      end,
    })

    vim.keymap.set('n', '<Leader>pw', '<Plug>(printer_print)iw')
  end,
}
