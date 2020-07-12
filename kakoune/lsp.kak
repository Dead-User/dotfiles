
evaluate-commands %sh{
    if kak-lsp --help >/dev/null; then
        kak-lsp --kakoune -s $kak_session
    fi
}
hook global WinSetOption filetype=(rust|ocaml|lua) %{
   lsp-enable-window
   map window user t :lsp-hover<ret>
}

set global lsp_hover_anchor true


#define-command lsp-reload-window \
#  -params 0 \
#  %{ lsp-disable-window; lsp-enable-window }
