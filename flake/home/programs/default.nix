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
  ];

  programs.home-manager.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
  programs.fzf.fileWidgetCommand = "fd --hidden --follow --no-ignore --max-depth 1 --exclude .git --exclude node_modules";
  programs.fzf.defaultOptions = [ "--no-separator" ];

  programs.rofi.enable = true;

  programs.feh.enable = true;
  programs.feh.buttons = {
    reload = null;
    pan = 1;
    zoom = null;
    toggle_menu = 3;
    prev_img = null;
    next_img = null;
    blur = null;
    rotate = null;
    zoom_in = 4;
    zoom_out = 5;
    orient_1 = 2;
  };
  programs.feh.keybindings = {
    toggle_actions = null;
    toggle_aliasing = null;
    toggle_caption = null;
    toggle_filenames = null;
    toggle_exif = null;
    toggle_fullscreen = "f";
    toggle_fixed_geometry = null;
    toggle_pause = null;
    toggle_info = "i";
    toggle_keep_vp = null;
    save_filelist = null;
    toggle_menu = "l";
    next_img = "Right";
    toggle_pointer = null;
    prev_img = "Left";
    quit = "q";
    reload_image = null;
    save_image = "s";
    size_to_image = null;
    close = null;
    jump_random = null;
    toggle_auto_zoom = null;
    prev_dir = null;
    next_dir = null;
    orient_3 = null;
    orient_1 = null;
    flip = null;
    mirror = null;
    jump_first = null;
    jump_last = null;
    jump_fwd = null;
    jump_back = null;
    reload_plus = null;
    reload_minus = null;
    remove = null;
    delete = "d";
    scroll_left = null;
    scroll_right = null;
    scroll_up = null;
    scroll_down = null;
    scroll_left_page = null;
    scroll_right_page = null;
    scroll_up_page = null;
    scroll_down_page = null;
    render = null;
    zoom_in = "equal";
    zoom_out = "minus";
    zoom_default = null;
    zoom_fit = null;
    zoom_fill = null;
    menu_close = "q";
    menu_up = "k";
    menu_down = "j";
    menu_parent = "h";
    menu_child = "l";
    menu_select = "Return";
  };

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.bashrcExtra = ''
    bind -x '"\C-n":"nvim"'
    stty -ixon # unbind ctrl-s and ctrl-q (terminal scroll lock)
  '';

  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config.modifier = "Mod4";
  xsession.windowManager.i3.config.floating.modifier = "Mod4";
  xsession.windowManager.i3.config.terminal = "alacritty";
  xsession.windowManager.i3.config.window.hideEdgeBorders = "smart";
  xsession.windowManager.i3.config.focus.newWindow = "focus";
  xsession.windowManager.i3.config.fonts = {
    names = [ "Noto Sans Regular" ];
    size = 20.0;
  };
  xsession.windowManager.i3.config.colors.focused = {
    background = "#00000000";
    border = "#00000000";
    childBorder = "#0080ff60";
    indicator = "#e345ff";
    text = "#ffffff";
  };
  xsession.windowManager.i3.config.keybindings =
  let
    mod = config.xsession.windowManager.i3.config.modifier;
  in {
    # Keybindings
    "${mod}+q" = "kill";
    "${mod}+space" = "floating toggle";
    "${mod}+u" = "exec warpd --grid";
    # Focus workspace
    "${mod}+1" = "workspace 1";
    "${mod}+2" = "workspace 2";
    "${mod}+3" = "workspace 3";
    "${mod}+4" = "workspace 4";
    "${mod}+5" = "workspace 5";
    "${mod}+6" = "workspace 6";
    "${mod}+7" = "workspace 7";
    "${mod}+8" = "workspace 8";
    "${mod}+9" = "workspace 9";
  };

  xsession.windowManager.i3.extraConfig = ''
  for_window [class=.*] border pixel 6, focus
  '';

  programs.tmux.enable = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.disableConfirmationPrompt = true;
  programs.tmux.escapeTime = 0;
  # programs.tmux.extraConfig;

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
