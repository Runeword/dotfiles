{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./modules
  ];

  fonts.fontconfig.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/zip" = ["xarchiver.desktop"];

    "image/jpeg" = ["imv.desktop"];
    "image/png" = ["imv.desktop"];
    "image/avif" = ["imv.desktop"];
    "image/bmp" = ["imv.desktop"];
    "image/tiff" = ["imv.desktop"];
    "image/svg+xml" = ["imv.desktop"];
    "image/gif" = ["imv.desktop"];
    "image/vnd.microsoft.icon" = ["imv.desktop"];
    "image/webp" = ["imv.desktop"];

    "application/json" = ["nvim.desktop"];
    "application/ld+json" = ["nvim.desktop"];
    "application/x-sh" = ["nvim.desktop"];
    "application/xml" = ["nvim.desktop"];
    "text/plain" = ["nvim.desktop"];
    "text/css" = ["nvim.desktop"];
    "text/csv" = ["nvim.desktop"];
    "text/html" = ["nvim.desktop"];
    "text/calendar" = ["nvim.desktop"];
    "text/javascript" = ["nvim.desktop"];

    # application/msword
    # application/vnd.openxmlformats-officedocument.wordprocessingml.document
    #
    # application/vnd.amazon.ebook
    # application/epub+zip
    #
    # video/mp4
    # video/mpeg
    # video/ogg
    # video/mp2t
    # video/webm
    #
    # application/gzip
    # application/vnd.rar
    # application/zip
    # application/x-7z-compressed
    #
    # application/java-archive
    # application/vnd.apple.installer+xml
    # application/vnd.oasis.opendocument.presentation
    # application/vnd.oasis.opendocument.spreadsheet
    # application/vnd.oasis.opendocument.text
    # application/ogg
    #
    # audio/ogg
    # audio/opus
    # audio/midi, audio/x-midi
    # audio/mpeg
    # audio/wav
    # audio/webm
    #
    # font/otf
    # font/ttf
    # font/woff
    # font/woff2
    #
    # application/pdf
    # application/x-httpd-php
    # application/vnd.ms-powerpoint
    # application/vnd.openxmlformats-officedocument.presentationml.presentation
    # application/rtf
    # application/x-tar
    # application/vnd.visio
    #
    # application/xhtml+xml
    # application/vnd.ms-excel
    # application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    # application/vnd.mozilla.xul+xml
  };

  # home.packages = [ inputs.src-cli.packages.x86_64-linux.default ];
  # xresources.properties."Xft.dpi" = 200;

  # xsession.enable = true;
  # xsession.profileExtra = ''
  # xset r rate 180 40 &
  # '';
}
