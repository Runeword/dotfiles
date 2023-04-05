{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./shellAliases.nix];
  home.username = "charles";
  home.homeDirectory = "/home/charles";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    htop
    qmk
    xarchiver
    wget
    doppler
    ripgrep
    deno
    shopify-cli
    progress
    fd
    inkscape
    vifm
    xclip
    chezmoi
    trashy
    bat
    rofi
    peek
    gcc
    colorpicker
    realesrgan-ncnn-vulkan
    slack
    bitwarden-cli
    nodePackages.firebase-tools
    # supabase-cli
    google-chrome
    firefox
    (nerdfonts.override {fonts = ["Hack" "DroidSansMono"];})
    neovim-nightly
    # python311
  ];

  home.sessionVariables = {
    # FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --follow --exclude .git";
    # FZF_CTRL_T_COMMAND="${config.home.sessionVariables.FZF_DEFAULT_COMMAND}";
    _ZO_FZF_OPTS = "--reverse --height 40% --no-separator --border none"; # zoxide fzf options
  };

  # home.sessionVariables = {
  #   FOO = "Hello";
  #   BAR = "${config.home.sessionVariables.FOO} World!";
  # };

  nixpkgs.overlays = [
    # (self: super: {

    # supabase-cli = super.supabase-cli.override (old: {
    #     buildGoModule = args: pkgs.buildGoModule (args // {
    #         version = "1.45.1";
    #         src = super.fetchFromGitHub {
    #         owner = "supabase";
    #         repo = "cli";
    #         rev = "v1.45.1";
    #         sha256 = "sha256-fj8kMvHSs1ZOnMgyaWAyIAwzK6LJz0gxhJ+Dpf5hwis=";
    #         };
    #         ldflags = [ "-s" "-w" "-X" "github.com/supabase/cli/cmd.version=1.45.1" ];
    #         vendorSha256 = "sha256-bxqfg77f6BuUy+9KrcToWJRzfwshOdqEQkAq4IFaxS8=";
    #         postInstall = ''
    #             rm $out/bin/{codegen,listdep}
    #             mv $out/bin/{cli,supabase}
    #             installShellCompletion --cmd supabase \
    #               --bash <($out/bin/supabase completion bash) \
    #               --fish <($out/bin/supabase completion fish) \
    #               --zsh <($out/bin/supabase completion zsh)
    #           '';
    #         });
    # });

    # supabase-cli = super.supabase-cli.overrideAttrs (old: {
    #   src = super.fetchFromGitHub {
    #     owner = "supabase";
    #     repo = "cli";
    #     rev = "v1.45.1";
    #     sha256 = "sha256-fj8kMvHSs1ZOnMgyaWAyIAwzK6LJz0gxhJ+Dpf5hwis=";
    #   };
    #   ldflags = [ "-s" "-w" "-X" "github.com/supabase/cli/cmd.version=1.45.1" ];
    # });

    # })
  ];
}
