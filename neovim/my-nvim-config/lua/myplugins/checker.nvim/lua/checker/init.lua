local vim = vim

local M = {}

local function openDiagnosticInSplit(diag)
  if not diag then return end

  -- print(vim.inspect(diag))
  -- vim.diagnostic.goto_next({ float = false, })
  vim.api.nvim_win_set_cursor(0, {diag.lnum + 1, diag.col})

  local current_window = vim.api.nvim_get_current_win()
  local current_buffer = vim.api.nvim_get_current_buf()
  -- local current_filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  -- vim.diagnostic.goto_next({win_id = current_window })

  local buffer_id = vim.fn.bufnr('diagnostic_message')
  if buffer_id == -1 then
    -- Create a new buffer
    buffer_id = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buffer_id, 'diagnostic_message')

    -- Open a new split window
    vim.api.nvim_command('belowright 5 split')

    -- Set the new buffer in the split window
    vim.api.nvim_win_set_buf(0, buffer_id)
    vim.api.nvim_buf_set_option(buffer_id, 'number', false)
    -- vim.api.nvim_buf_set_option(buffer_id, 'filetype', current_filetype)
  end

  -- Set the diagnostic message in the new buffer
  local diag_line_raw = vim.api.nvim_buf_get_lines(current_buffer, diag.lnum, diag.lnum + 1, false)[1]
  local diag_line = diag_line_raw:gsub("^%s*", "")
  local offset = math.abs(#diag_line_raw - #diag_line)

  -- print(vim.inspect(diag))
  vim.api.nvim_buf_set_lines(buffer_id, 0, -1, false,
    {
      diag_line,
      (diag.source or '') .. ' ' .. (diag.code or ''),
      (diag.message or ''),
    })

  -- local parser = vim.treesitter.get_string_parser(diag_line, 'lua')
  -- local tree = (parser:parse() or {})[1]
  -- -- print(diag_line)
  -- -- print(vim.inspect(tree))
  -- local root = tree:root()
  -- local highlighter = vim.treesitter.highlighter.new(parser)
  -- highlighter:put(buffer_id, root)

  local severity_highlight = {
    [1] = 'DiagnosticUnderlineError',
    [2] = 'DiagnosticUnderlineWarn',
    [3] = 'DiagnosticUnderlineInfo',
    [4] = 'DiagnosticUnderlineHint',
  }
  vim.api.nvim_buf_add_highlight(buffer_id, -1, severity_highlight[diag.severity], 0,
    diag.col - offset, diag.end_col - offset)

  -- vim.api.nvim_set_option_value('modifiable', false, { buf = buffer_id })
  vim.api.nvim_set_current_win(current_window)
end

function M.nextDiagnostic()
  openDiagnosticInSplit(vim.diagnostic.get_next())
end

function M.prevDiagnostic()
  openDiagnosticInSplit(vim.diagnostic.get_prev())
end

return M
