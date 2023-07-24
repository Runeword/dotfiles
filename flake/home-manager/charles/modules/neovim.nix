{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = false;
  programs.neovim.withNodeJs = true;
  programs.neovim.withPython3 = true;
  programs.neovim.package = pkgs.neovim-nightly;

  # install language servers
  programs.neovim.extraPackages = with pkgs; [
    nodePackages.vls
    nodePackages.typescript-language-server
    vscode-langservers-extracted
    nodePackages.bash-language-server
    nodePackages.yaml-language-server
    nodePackages.eslint
    lua-language-server
    marksman
    ccls
    nil
    alejandra
    nixpkgs-fmt
    shfmt
    shellcheck
  ];

  # programs.neovim.plugins = with pkgs; [
  #   vimPlugins.nvim-treesitter
  #   vimPlugins.nvim-treesitter.withAllGrammars
  #   vimPlugins.nvim-treesitter-textobjects
  #   vimPlugins.codeium-vim
  # ];

  # programs.neovim.extraConfig = "luafile ~/flake/config/nvim/init.lua";

  # let
  #   fromGitHub = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
  #     pname = "${lib.strings.sanitizeDerivationName repo}";
  #     version = ref;
  #     src = builtins.fetchGit {
  #       url = "https://github.com/${repo}.git";
  #       ref = ref;
  #     };
  #   };
  # in {
  # programs.neovim.plugins = with pkgs.vimPlugins; [
  #   nvim-lspconfig
  #   nvim-treesitter
  #   plenary-nvim
  #   (fromGitHub "HEAD" "itchyny/vim-cursorword")
  #   (fromGitHub "HEAD" "windwp/nvim-ts-autotag")
  #   (fromGitHub "HEAD" "tommcdo/vim-exchange")
  #   (fromGitHub "HEAD" "kyazdani42/nvim-web-devicons")
  #   (fromGitHub "HEAD" "kana/vim-arpeggio")
  # ];
}
