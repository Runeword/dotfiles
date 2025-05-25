### Neovim

#### Standalone run

* Development mode :
  ```shell
  cloneit https://github.com/Runeword/dotfiles/tree/main/neovim && \
  cd neovim && NVIM_CONFIG_DIR="$PWD" nix run .#dev --impure
  ```

* Bundled mode :

  ```shell
  nix run "github:Runeword/dotfiles?dir=neovim" \
  --option substituters "https://runeword-neovim.cachix.org" \
  --option trusted-public-keys "runeword-neovim.cachix.org-1:Vvtv02wnOz9tp/qKztc9JJaBc9gXDpURCAvHiAlBKZ4="
  ```

#### Home Manager

* Development mode :

  `flake.nix`
  ```nix
  inputs.runeword-neovim.url = "github:Runeword/dotfiles?dir=neovim";
  ```

  `home.nix`
  ```nix
  home.packages = [
    (inputs.runeword-neovim.lib.mkConfig { path = "<your-neovim-config-dir>"; }).packages.${pkgs.system}.dev
  ];
  ```

* Bundled mode :

  `flake.nix`
  ```nix
  nixConfig.extra-substituters = [ "https://runeword-neovim.cachix.org" ];
  nixConfig.extra-trusted-public-keys = [ "runeword-neovim.cachix.org-1:Vvtv02wnOz9tp/qKztc9JJaBc9gXDpURCAvHiAlBKZ4=" ];
  inputs.runeword-neovim.url = "github:Runeword/dotfiles?dir=neovim";
  ```

  `home.nix`
  ```nix
  home.packages = [
    inputs.runeword-neovim.packages.${pkgs.system}.dev
  ];
  ```
