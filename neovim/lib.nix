{ pkgs, homePath }:

path:
let
  pathStr = toString path;
  drvName = builtins.baseNameOf pathStr;
  fullPath = "${homePath}/${pathStr}";
in
pkgs.runCommandLocal drvName { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out''
