# auto swapping input method when switching between modes

# the return value from `fcitx-remote'.
#   1 => input method inactive
#   2 => input method activated 
declare-option -hidden int fcitx_im_status 1

hook global BufCreate .* %{
    set-option buffer fcitx_im_status 1

    hook buffer ModeChange push:normal:insert %{ nop { %sh{
        if [ $kak_opt_fcitx_im_status = 2 ]; then
          fcitx-remote -o
        fi
    }}}

    hook buffer ModeChange pop:normal:insert %{ nop { %sh{
        if [ $kak_opt_fcitx_im_status = 2 ]; then
          fcitx-remote -o
        fi
    }}}

    hook buffer ModeChange push:insert:normal %{ set-option buffer fcitx_im_status %sh{
        state=$(fcitx-remote)
        if [ $state = 2 ]; then
          fcitx-remote -c
        fi
        echo $state
    }}

    hook buffer ModeChange pop:insert:normal %{ set-option buffer fcitx_im_status %sh{
        state=$(fcitx-remote)
        if [ $state = 2 ]; then
          fcitx-remote -c
        fi
        echo $state
    }}
}
