{ pkgs }:

{
  mkOutOfStoreSymlink = path:
    let
      pathStr = toString path;
      name = builtins.baseNameOf pathStr;
      fullPath = "${builtins.toString /home/charles/terminal}/${pathStr}";
    in
    pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';
} 