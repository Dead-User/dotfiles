
# evaluate-commands %sh{ kak-lsp --kakoune -s $kak_session }
hook global WinSetOption filetype=(rust|ocaml|lua) %{
   lsp-enable-window
   map window user t :lsp-hover<ret>
}

set global lsp_hover_anchor true


#define-command lsp-reload-window \
#  -params 0 \
#  %{ lsp-disable-window; lsp-enable-window }
