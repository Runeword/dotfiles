{ config, pkgs, libs, ... }: {
  #let
  #  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
  #    pname = "${lib.strings.sanitizeDerivationName repo}";
  #    version = ref;
  #    src = builtins.fetchGit {
  #      url = "https://github.com/${repo}.git";
  #      ref = ref;
  #    };
  #  };
  #in {

  imports = [
    ./readline.nix
    ./alacritty.nix
    ./i3.nix
    ./feh.nix
    ./ssh.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.fileWidgetCommand = "fd --hidden --follow --no-ignore --max-depth 1 --exclude .git --exclude node_modules";
  programs.fzf.defaultOptions = [ "--no-separator" ];

  programs.rofi.enable = true;

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.bashrcExtra = ''
    bind -x '"\C-n":"nvim"'
    stty -ixon # unbind ctrl-s and ctrl-q (terminal scroll lock)
  '';

  # programs.neovim.enable = true;
  # programs.neovim.defaultEditor = true;
  # programs.neovim.viAlias = true;
  # programs.neovim.package = pkgs.neovim-nightly;
  # programs.neovim.extraConfig = "luafile ~/flake/config/nvim/init.lua";

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
