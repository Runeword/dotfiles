{ pkgs, basePath }:

path:
let
  pathStr = toString path;
  drvName = builtins.baseNameOf pathStr;
  fullPath = "${basePath}/${pathStr}";
in
pkgs.runCommandLocal drvName { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out''
