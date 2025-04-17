{
  pkgs,
  utils,
  system,
}:

let
  common = (import ./packages.nix { inherit pkgs; }) ++ [
  ];

  linux = pkgs.lib.optionals (system == "x86_64-linux" || system == "aarch64-linux") (
    import ./packages-linux.nix { inherit pkgs; }
  );

  zsh = import ./zsh.nix {
    inherit pkgs;
    mkOutOfStoreSymlink = utils.mkOutOfStoreSymlink;
  };

  tmux = import ./tmux.nix {
    inherit pkgs;
    mkOutOfStoreSymlink = utils.mkOutOfStoreSymlink;
  };

  bash = import ./bash.nix {
    inherit pkgs;
    mkOutOfStoreSymlink = utils.mkOutOfStoreSymlink;
  };

  custom = [
    zsh
    tmux
    bash
  ];
in
{
  inherit common linux custom;
}
