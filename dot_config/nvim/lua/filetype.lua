local vim = vim

vim.filetype.add({
  pattern = { ['.*/hyprland%.conf'] = 'hyprlang', },
})
