#!/bin/sh

__wallpaper() {
	hyprctl hyprpaper preload "$1" &&
		hyprctl hyprpaper wallpaper eDP-1,"$1" &&
		hyprctl hyprpaper unload all
}
