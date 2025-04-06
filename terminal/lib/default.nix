{ pkgs }:

{
  mkOutOfStoreSymlink = 
    path:
    let
      pathStr = toString path;
      name = builtins.baseNameOf pathStr;
      fullPath = "${toString /home/charles/term}/${pathStr}";
    in
    pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';
}
