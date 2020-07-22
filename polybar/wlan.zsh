
echo "
[module/wlan]
type = internal/network
interface = wlp0s20f3
interval = 1.0

format-connected = <label-connected>
label-connected = $(with_color $color_green  ) %downspeed%#%essid%

format-disconnected =
"
