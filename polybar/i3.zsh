
echo "
[module/i3]
type = internal/i3
index-sort = true

wrapping-scroll = false
enable-click = true
enable-scroll = false

format = <label-state><label-mode>
strip-wsnumbers = true

label-focused = \" %name% \"
label-focused-background = $color_darkgrey
label-focused-foreground = $color_gold
label-focused-padding = 0

label-unfocused = \" %name% \"
label-unfocused-padding = 0

label-visible = \" %name% \"
label-visible-foreground = $color_gold
label-visible-padding = 0

label-mode = \" %mode% \"
label-mode-padding = 0
label-mode-foreground = $color_green
"
