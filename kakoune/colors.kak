
evaluate-commands %sh{
    # color definitions
    WHITE1=rgb:ffffff
    WHITE2=rgb:aaaaaa

    BLACK1=rgb:202020
    BLACK2=rgb:404040
    BLACK3=rgb:606060
    BLACK4=rgb:808080

    RED1=red

    ORANGE1=rgb:ff8000

    YELLOW1=yellow

    BLUE1=blue

    GREEN1=green


    # builtin faces
    echo set-face global StatusLine     default,$BLACK2
    echo set-face global Information    default,$BLACK2
    echo set-face global MenuBackground default,$BLACK3
    echo set-face global MenuForeground default,$BLACK2

    echo set-face global SecondarySelection default,$BLACK4+f
    echo set-face global SecondaryCursor    $BLACK1,$WHITE2+fb
    echo set-face global PrimaryCursor      default,$BLACK1+rfb


    # code faces
    echo set-face global value $ORANGE1,default

    # lsp faces
    echo set-face global DiagnosticWarning default,default
}
