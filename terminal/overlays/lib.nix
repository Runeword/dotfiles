{ flakePath }:

final: prev: {
  lib = prev.lib // {
    flakePath = "${flakePath}";

    # mkOutOfStoreSymlink =
    #   path:
    #   let
    #     pathStr = toString path;
    #     name = builtins.baseNameOf pathStr;
    #     fullPath = "${flakePath}/${pathStr}";
    #   in
    #   prev.runCommandLocal name { } ''ln -s ${prev.lib.escapeShellArg fullPath} $out'';

    mkLink = source: target: ''
      mkdir -p $(dirname $out/${prev.lib.escapeShellArg target})
      ln -sf ${prev.lib.escapeShellArg source} $out/${prev.lib.escapeShellArg target}
    '';

    mkCopy = source: target: ''
      mkdir -p $(dirname $out/${prev.lib.escapeShellArg target})
      cp -r ${prev.lib.escapeShellArg source} $out/${prev.lib.escapeShellArg target}
    '';
  };
}
