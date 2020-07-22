
echo "
[module/volume]
type = internal/alsa

format-volume = <label-volume>
label-volume = $(with_color $color_green  ) %percentage%%

format-muted = <label-muted>
label-muted = $(with_color $color_orange M)
"
