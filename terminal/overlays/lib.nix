{ flakePath }:

final: prev: {
  lib = prev.lib // {
    mkOutOfStoreSymlink =
      path:
      let
        pathStr = toString path;
        name = builtins.baseNameOf pathStr;
        fullPath = "${flakePath}/${pathStr}";
      in
      prev.runCommandLocal name { } ''ln -s ${prev.lib.escapeShellArg fullPath} $out'';
  };
}
