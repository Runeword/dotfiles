{ flakePath }:

final: prev: {
  lib = prev.lib // {
    flakePath = "${flakePath}";

    mkLink = source: target: ''
      mkdir -p $(dirname ${prev.lib.escapeShellArg "$out/${target}"})
      ln -sf ${prev.lib.escapeShellArg source} ${prev.lib.escapeShellArg "$out/${target}"}
    '';

    mkCopy = source: target: ''
      mkdir -p $(dirname ${prev.lib.escapeShellArg "$out/${target}"})
      cp -r ${prev.lib.escapeShellArg source} ${prev.lib.escapeShellArg "$out/${target}"}
    '';
  };
}
