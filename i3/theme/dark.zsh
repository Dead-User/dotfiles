
#                        border  background   text    indicator child-border
COLOR_FOCUSED=(         '#202020' '#202020' '#FEEEED' '#2E9EF4'  '#FFFFFF' )
COLOR_UNFOCUSED=(       '#404040' '#404040' '#FEEEED' '#2E9EF4'  '#222222' )
COLOR_FOCUSED_INACTIVE=('#303030' '#303030' '#FEEEED' '#FEEEED'  '#FFFFFF' )

BG_SET=""

# FONTS=('Kochi Mincho 12' 'WenQuanYi Micro Hei Mono 12' 'Monaco 12')
FONTS=('Sarasa Gothic CL 12' 'Iosevka Monaco 12')

TERMINAL_CMD='alacritty'

PROGRAM_LAUNCHER="dmenu_run -i -fn 'Iosevka Monaco-12' -nb '#202020' -nf '#EBE4DA' -sb '#404040' -sf '#EBE4DA'"

EXTRA_SETTINGS=""

EXTRA_INITS=$(
    # custom layout script for the 'sys' workspace
    echo -n exec --no-startup-id
    echo \"i3-msg \'workspace 5:sys\; append_layout ~/.config/i3/layouts/layout-sys-tabbed.json\'\"
    echo exec $TERMINAL_CMD --class=htop    --title=htop -e htop
    echo exec $TERMINAL_CMD --class=vimpc   --title=vimpc -e vimpc
    echo exec $TERMINAL_CMD --class=neomutt --title=neomutt -e neomutt
    echo exec $TERMINAL_CMD
)
