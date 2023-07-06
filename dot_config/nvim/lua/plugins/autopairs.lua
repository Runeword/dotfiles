local vim = vim

return {
  'windwp/nvim-autopairs',

  config = function()
    local remap = vim.api.nvim_set_keymap
    local npairs = require('nvim-autopairs')

    npairs.setup({
      map_bs = true,
      map_cr = false,
      check_ts = true,
      ignored_next_char = '[%w%.]',
      -- fast_wrap = {
      --   map = "<C-h>",
      --   chars = { "{", "[", "(", '"', "'" },
      --   pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      --   offset = 0,
      --   end_key = "s",
      --   keys = "aoeuhtns",
      --   check_comma = true,
      --   highlight = "Search",
      --   highlight_grey = "Comment",
      -- },
    })

    -- skip it, if you use another global object
    _G.MUtils = {}

    MUtils.CR = function()
      if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({ 'selected', }).selected ~= -1 then
          return npairs.esc('<c-y>')
        else
          return npairs.esc('<c-e>') .. npairs.autopairs_cr()
        end
      else
        return npairs.autopairs_cr()
      end
    end
    remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true, })

    MUtils.BS = function()
      if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode', }).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
      else
        return npairs.autopairs_bs()
      end
    end
    remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true, })
  end,
}
