{ flakePath, self }:

final: prev: {
  lib = prev.lib // {
    flakePath = "${flakePath}";

    mkLink = source: target: ''
      mkdir -p $(dirname $out/${prev.lib.escapeShellArg target})
      ln -sf ${prev.lib.escapeShellArg source} $out/${prev.lib.escapeShellArg target}
    '';

    mkCopy = source: target: ''
      mkdir -p $(dirname $out/${prev.lib.escapeShellArg target})
      cp -r ${prev.lib.escapeShellArg source} $out/${prev.lib.escapeShellArg target}
    '';

    mkFile = rootPath: source: target:
      if builtins.hasAttr "rev" self
        then final.lib.mkCopy (prev.lib.cleanSource (rootPath + source)) target 
        else final.lib.mkLink "${flakePath}/${source}" target;
  };
}
