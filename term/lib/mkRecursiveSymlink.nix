# Function to recursively create symlinks for directories
{
  pkgs,
  workspacePath ? /home/charles/term,
  symlink,
}:

path:
let
  pathStr = toString path;
  name = builtins.baseNameOf pathStr;
  fullPath = "${toString workspacePath}/${pathStr}";

  # Check if this is a directory
  isDir = builtins.pathExists fullPath && builtins.readDir fullPath != { };
in
if isDir then
  # For directories, create a derivation that will symlink the directory
  pkgs.runCommandLocal name { } ''
    mkdir -p $out
    ln -s ${pkgs.lib.escapeShellArg fullPath}/* $out/
  ''
else
  # For files, use the provided symlink function
  symlink path
