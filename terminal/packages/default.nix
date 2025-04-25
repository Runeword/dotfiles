{
  pkgs,
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
    })
    (import ./tmux.nix {
      inherit pkgs;
    })
    (import ./bash.nix {
      inherit pkgs;
    })
  ];
in
{
  inherit common linux custom;
}
