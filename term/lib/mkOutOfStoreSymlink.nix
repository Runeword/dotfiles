# Function to create a symlink to a file outside the Nix store
{
  pkgs,
  workspacePath ? /home/charles/term,
}:

path:
let
  pathStr = toString path;
  name = builtins.baseNameOf pathStr;
  fullPath = "${toString workspacePath}/${pathStr}";
  # Check if this is a directory by trying to list it
  isDir = builtins.pathExists fullPath && builtins.readDir fullPath != {};
in
if isDir then
  # For directories, create a derivation that will symlink the directory
  pkgs.runCommandLocal name {} ''
    mkdir -p $out
    ln -s ${pkgs.lib.escapeShellArg fullPath}/* $out/
  ''
else
  # For files, use the original implementation
  pkgs.runCommandLocal name {} ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out''
