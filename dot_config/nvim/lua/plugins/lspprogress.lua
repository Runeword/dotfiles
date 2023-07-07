return {
  'linrongbin16/lsp-progress.nvim',

  event = { 'VimEnter', },

  dependencies = { 'nvim-tree/nvim-web-devicons', },

  config = function()
    require('lsp-progress').setup({
      spinner = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷', },
      spin_update_time = 200,
      decay = 1000,
      event = 'LspProgressStatusUpdated',
      event_update_time_limit = 100,
      max_size = -1,
      debug = false,
      console_log = true,
      file_log = false,
      file_log_name = 'lsp-progress.log',

      series_format = function(title, message, percentage, done)
        local builder = {}
        local has_title = false
        local has_message = false
        if title and title ~= '' then
          table.insert(builder, title)
          has_title = true
        end
        if message and message ~= '' then
          table.insert(builder, message)
          has_message = true
        end
        if percentage and (has_title or has_message) then
          table.insert(builder, string.format('(%.0f%%%%)', percentage))
        end
        if done and (has_title or has_message) then
          table.insert(builder, '- done')
        end
        return table.concat(builder, ' ')
      end,

      -- Format client message.
      -- `[null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`.
      client_format = function(client_name, spinner, series_messages)
        return #series_messages > 0
            and ('[' .. client_name .. '] ' .. spinner .. ' ' .. table.concat(
              series_messages,
              ', '
            ))
            or nil
      end,

      -- Format (final) message.
      -- ` LSP [null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`
      format = function(client_messages)
        local sign = 'LSP'
        return #client_messages > 0
            and (sign .. ' ' .. table.concat(client_messages, ' '))
            or sign
      end,
    })
  end,
}
