
hook global WinSetOption filetype=coq %{
    coq-start

    declare-user-mode coq

    map buffer user c ": enter-user-mode coq<ret>" \
        -docstring "enter the Coq user mode"

    map buffer coq c ": enter-user-mode -lock coq<ret>" \
        -docstring "stay in the Coq user mode"

    map buffer coq r ": coq-back<ret>" \
        -docstring "undo last sent command"

    map buffer coq h ": coq-next<ret>" \
        -docstring "send the next command to Coq"

    map buffer coq <ret> ": coq-to-cursor<ret>" \
        -docstring "move tip to main cursor"
}
