
echo "
[module/current-monitor]
type = custom/script
exec = current-monitor
tail = false

format = $(with_color $color_cyan  ) <label>
label = %output%
interval = 1
"
