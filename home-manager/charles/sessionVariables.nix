{ config
, pkgs
, lib
, ...
}: {
  home.sessionVariables = rec {
    # XDG Base Directory Specification
    XDG_CONFIG_DIRS = "/etc/xdg";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    XDG_BIN_HOME = "${config.home.homeDirectory}/.local/bin";
  };
}
