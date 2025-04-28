{ rootStr, self }:

final: prev: {
  lib = prev.lib // {
    mkLink = sourceStr: targetStr: ''
      mkdir -p $(dirname $out/${prev.lib.escapeShellArg targetStr})
      ln -sf ${prev.lib.escapeShellArg (rootStr + "/" + sourceStr)} $out/${prev.lib.escapeShellArg targetStr}
    '';

    mkCopy = source: target: ''
      mkdir -p $(dirname $out/${prev.lib.escapeShellArg target})
      cp -r ${prev.lib.escapeShellArg (prev.lib.cleanSource source)} $out/${prev.lib.escapeShellArg target}
    '';

    mkFile =
      rootPath: source: target:
      if builtins.hasAttr "rev" self then
        final.lib.mkCopy (rootPath + source) target
      else
        final.lib.mkLink source target;
  };
}
