
source ~/.config/i3/theme/dark.zsh

EXTRA_INITS=$(
    echo $EXTRA_INITS
    echo 'exec sh -c "sleep 0.3; picom -bc --vsync"'
)

