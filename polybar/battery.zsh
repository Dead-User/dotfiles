
echo "
[module/battery]
type = internal/battery
battery = BAT0
adapter = ADP1
full-at = 98

format-charging = <label-charging>
label-charging = $(with_color $color_cyan  ) %percentage:2%%

format-discharging = <ramp-capacity> <label-discharging>
label-discharging = %percentage:2%%
ramp-capacity-0 = $(with_color $color_alert  )
ramp-capacity-1 = $(with_color $color_orange  )
ramp-capacity-2 = $(with_color $color_gold  )
ramp-capacity-3 = $(with_color $color_green  )
ramp-capacity-4 = $(with_color $color_blue  )

format-full = <label-full>
label-full = $(with_color $color_blue  ) %percentage:2%%
"
