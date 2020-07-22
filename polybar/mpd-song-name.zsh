
echo "
[module/mpd-song-name]
type = custom/script
exec = my-mpd-status.zsh -p 0.5 -w 15
tail = true

format = <label>
label = \"$(with_color $color_cyan  ) %output%\"
interval = 1

click-left = mpc toggle
"
