#!/usr/bin/env zsh

# My polybar config enchaned.
# More modular, more flexible.
# Not intended to be generic for everyone, just to give myself
# more power and ease in configuration.

######## I. Variables & Helpers ########
color_bg="#222"
color_fg="#ffffff"
color_darkgrey="#444444"
color_alert="#bd2c40"
color_green="#8fff00"
color_blue="#00a0ff"
color_cyan="#00e0ff"
color_gold="#ffd700"
color_orange="#ffa000"

fonts_latin="Iosevka Monaco:pixelsize=13"
fonts_cjk="Sarasa Gothic CL:pixelsize=14"
fonts_icon="Font Awesome 5 Free:size=12:style=solid"

function with_color() {
    color=$1
    text=$2
    echo "%{F$color}$text%{F-}"
}

######## II. Modules ########
config_dir=${0:0:(-14)}
for module in backlight volume notification current-monitor i3 \
    mpd-song-name mpd wlan battery temperature date;
do
    source $config_dir/$module.zsh
done

######## III. Bars ########
echo "
[bar/bar1]
monitor = eDP-1

width = 100%
height = 25
offset-x = 0
offset-y = 0
radius = 0.6
fixed-center = true
bottom = true

enable-ipc = true

background = $color_bg
foreground = $color_fg

font-0 = $fonts_latin
font-1 = $fonts_cjk
font-2 = $fonts_icon

border-size = 0

line-size = 2

padding-left = 2
padding-right = 2

module-margin-left = 1
module-margin-right = 2

modules-left = backlight volume notification current-monitor i3
modules-center = mpd-song-name mpd
modules-right = wlan battery temperature date
"
