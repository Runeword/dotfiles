{pkgs, ...}: {
  home.packages = with pkgs; [
    peek
    xclip
    colorpicker
    xev
  ];
}
