local vim = vim

return {
  'junegunn/fzf',
  enabled = false,

  config = function()
    vim.cmd [[
      autocmd! FileType fzf
      autocmd FileType fzf tnoremap <buffer> <esc> <c-c>
      autocmd  FileType fzf set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
      ]]

    vim.keymap.set('n', '<Tab>',
      function()
        vim.fn['fzf#run'] {
          sink = 'e',
          window = { width = 0.9, height = 0.6, },
          options = { '--reverse', '--prompt=  ', '--preview=bat --style=plain --color=always {1}', '--no-scrollbar', '--preview-window=right,55%,border-none', '--no-separator', '--inline-info' },
        }
      end,
      { silent = true, })
  end,
}
