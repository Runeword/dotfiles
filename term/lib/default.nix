{ pkgs }:

{
  mkOutOfStoreSymlink = import ./mkOutOfStoreSymlink.nix { 
    inherit pkgs; 
    workspacePath = /home/charles/term;
  };
}
