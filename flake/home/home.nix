{ config, pkgs, lib, ... }: {
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

    fonts.fontconfig.enable = true;

    home.shellAliases = import ./shellAliases.nix;
    home.username = "charles";
    home.homeDirectory = "/home/charles";
    home.stateVersion = "22.11";
    home.packages = with pkgs; [
      git
      htop
      wget
      ripgrep
      fd
      vifm
      xclip
      chezmoi
      bat
      gcc
      python311
      nodejs-19_x
      alacritty
      neovim-nightly
      bitwarden-cli
      google-chrome
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  
    programs.home-manager.enable = true;

    programs.readline = import programs/readline.nix;

    programs.fzf.enable = true;
    programs.fzf.enableBashIntegration = true;
    programs.fzf.fileWidgetCommand = "fd --hidden --follow --no-ignore --max-depth 1 --exclude .git --exclude node_modules";
    programs.fzf.defaultOptions = [ "--no-separator" ];
  
    programs.bash.enable = true;
    programs.bash.enableCompletion = true;
  
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
