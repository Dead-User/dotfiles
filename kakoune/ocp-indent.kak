
hook global WinSetOption filetype=ocaml %{
    declare-option str ocp_indent_filename %sh{ echo "/tmp/kak-ocp-indent-$kak_session-$(echo $kak_bufname | sed 's/\//-/g')" }
    hook window InsertChar . %{
        write %opt{ocp_indent_filename}
        evaluate-commands -itersel -draft %{
            evaluate-commands %sh{
                 INDENT=$(ocp-indent "$kak_opt_ocp_indent_filename" --lines $kak_cursor_line-$kak_cursor_line --numeric); \
                 echo "echo -debug $kak_cursor_line, $INDENT"
                 OLD_INDENT_WIDTH=$kak_opt_indentwidth; \
                 echo "set-option window indentwidth 1"; \
                 echo "try %{ execute-keys <a-x> s ^\h+ <ret> d }"; \
                 if [ $INDENT -gt 0 ]; then \
                     echo "execute-keys $INDENT >"; \
                 fi; \
                 echo "set-option window indentwidth $OLD_INDENT_WIDTH" \
            }
        }
        nop %sh{ rm "$kak_opt_ocp_indent_filename" }
    }
}
