{ pkgs }:

{
  mkOutOfStoreSymlink = import ./mkOutOfStoreSymlink.nix { inherit pkgs; };
}
