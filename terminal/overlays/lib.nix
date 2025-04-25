{ pkgs, flakePath }:

final: prev: {
  lib = prev.lib // {
    mkOutOfStoreSymlink =
      path:
      let
        pathStr = toString path;
        name = builtins.baseNameOf pathStr;
        fullPath = "${flakePath}/${pathStr}";
      in
      pkgs.runCommandLocal name { } ''ln -s ${pkgs.lib.escapeShellArg fullPath} $out'';
  };
}
