
let g:nvim_config_dir = expand("<sfile>:h")

function s:source_config(config)
    exec "source " . g:nvim_config_dir . "/" . a:config . ".vim"
endfunction

call s:source_config("packages")
call s:source_config("key-binding")
call s:source_config("user-options")
call s:source_config("user-commands")
call s:source_config("status-line")
call s:source_config("appearance")

function FileTypeHook()
    if has_key(g:LanguageClient_serverCommands, &l:filetype)
        call s:source_config("lsp")
    endif
    if &l:filetype == "ocaml"
        call s:source_config("ocaml")
    elseif &l:filetype == "coq"
        call s:source_config("coq")
    endif
endfunction
        
autocmd FileType * call FileTypeHook()
