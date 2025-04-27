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

    mkLink = source: target: ''
      mkdir -p $(dirname $out/${target})
      ln -sf ${source} $out/${target}
    '';

    mkCopy = source: target: ''
      mkdir -p $(dirname $out/${target})
      cp -r ${source} $out/${target}
    '';
  };
}
