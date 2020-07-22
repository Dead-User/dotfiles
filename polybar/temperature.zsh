
echo "
[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 70

format = <ramp> <label>
format-warn = <ramp> <label-warn>

label = %temperature-c%
label-warn = %temperature-c%
label-warn-foreground = $color_alert

ramp-0 = $(with_color $color_cyan )
ramp-1 = $(with_color $color_gold )
ramp-2 = $(with_color $color_alert )
"
