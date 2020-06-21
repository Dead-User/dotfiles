
evaluate-commands %sh{
    # color definitions
    white1=rgb:ffffff
    white2=rgb:aaaaaa

    black1=rgb:202020
    black2=rgb:404040
    black3=rgb:606060
    black4=rgb:808080

    red1=red

    orange1=rgb:ff8000

    yellow1=yellow
    gold1=rgb:ffd700

    blue1=rgb:00bfff
    blue2=rgb:528b8b

    cyan1=rgb:00ffff
    cyan2=rgb:00cdcd
    cyan3=rgb:00c5cd

    green1=green
    green2=rgb:9acd32
    green3=rgb:a2cd52


    # builtin faces
    echo set-face global StatusLine     default,$black2
    echo set-face global Information    default,$black2
    echo set-face global MenuBackground default,$black3
    echo set-face global MenuForeground default,$black2

    echo set-face global SecondarySelection default,$black4+f
    echo set-face global SecondaryCursor    $black1,$white2+fb
    echo set-face global PrimaryCursor      default,$black1+rfb


    # code faces
    echo set-face global comment  $blue2,default

    echo set-face global keyword  $cyan1,default
    echo set-face global operator $yellow1,default
    echo set-face global function $cyan3,default

    echo set-face global value    $gold1,default
    echo set-face global type     $orange1,default
    echo set-face global variable $orange1,default
    echo set-face global string   $orange1,default

    echo set-face global module   $green2,default
    echo set-face global attribute $green3,default

    # lsp faces
    echo set-face global DiagnosticWarning default,default
}
