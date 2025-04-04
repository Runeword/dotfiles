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
in
pkgs.runCommandLocal name {} ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out''
