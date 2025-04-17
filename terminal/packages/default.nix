{
  pkgs,
  utils,
  system,
}:

let
  common = (import ./packages-common.nix { inherit pkgs; }) ++ [
  ];

  linux = pkgs.lib.optionals (system == "x86_64-linux" || system == "aarch64-linux") (
    import ./packages-linux.nix { inherit pkgs; }
  );

  custom = [
    (import ./zsh.nix {
      inherit pkgs;
      mkOutOfStoreSymlink = utils.mkOutOfStoreSymlink;
    })
    (import ./tmux.nix {
      inherit pkgs;
      mkOutOfStoreSymlink = utils.mkOutOfStoreSymlink;
    })
    (import ./bash.nix {
      inherit pkgs;
      mkOutOfStoreSymlink = utils.mkOutOfStoreSymlink;
    })
  ];
in
{
  inherit common linux custom;
}
