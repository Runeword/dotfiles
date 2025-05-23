### Neovim
Start neovim in development mode
```shell
cloneit https://github.com/Runeword/dotfiles/tree/main/neovim
NVIM_CONFIG_DIR="$PWD/neovim" nix run "github:Runeword/dotfiles?dir=neovim#dev" --impure
```

Start neovim in bundled mode
```shell
nix run "github:Runeword/dotfiles?dir=neovim" \
--option substituters "https://runeword-neovim.cachix.org" \
--option trusted-public-keys "runeword-neovim.cachix.org-1:Vvtv02wnOz9tp/qKztc9JJaBc9gXDpURCAvHiAlBKZ4="
```
