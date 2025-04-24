{ pkgs }:

let
  flakePath = "/home/charles/terminal";
in
{
  mkOutOfStoreSymlink =
    path:
    let
      pathStr = toString path;
      name = builtins.baseNameOf pathStr;
      fullPath = "${flakePath}/${pathStr}";
    in
    pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';

  findFlakeDir = pkgs.writeScriptBin "find-flake-dir" ''
    ${builtins.readFile ./find-flake-dir.sh}
  '';

  inherit flakePath;
}
