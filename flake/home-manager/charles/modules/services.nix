{ config, pkgs, libs, ... }: {
  services.picom = {
    enable = true;
    shadow = false;
    vSync = true;
    backend = "glx";
    opacityRules = [ "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" ];
  };
}
