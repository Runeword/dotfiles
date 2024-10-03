# putter.nvim
*Simple implementation of put charwise and put linewise operations in lua*  

Try it out with [packer](https://github.com/wbthomason/packer.nvim)
```lua
use("Runeword/putter.nvim")
```
And add the following mappings
```lua
vim.keymap.set({'n', 'x'}, 'p', require('putter').putCharwise('p'))
vim.keymap.set({'n', 'x'}, 'P', require('putter').putCharwise('P'))
vim.keymap.set({'n','x'}, 'glp', require('putter').putLinewise(']p`]'))
vim.keymap.set({'n','x'}, 'glP', require('putter').putLinewise(']P`]'))
```
> Note that `]p` put under the current indentation level  
> Note that ``p`]`` put and move cursor to end of the text  
