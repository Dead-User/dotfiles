

" ------------------------------------------------------------
"                          NAVIGATION
" ------------------------------------------------------------
"I use a custom, non-QWERTY keyboard layout, so ...
noremap t h
noremap n l
noremap r k
noremap h j

noremap T b
noremap N w

nnoremap R <c-u>
nnoremap H <c-d>

noremap <c-t> ^
noremap <c-n> $

nnoremap j n
nnoremap k N

"This is borrowed from kakoune, meaning `match'
noremap m %


"Multi cursor. Many keys are borrowed from kakoune
let g:multi_cursor_use_default_mapping = 0

let g:multi_cursor_start_word_key      = "C"
let g:multi_cursor_quit_key            = ";"
nnoremap s :MultipleCursorsFind 


" ------------------------------------------------------------
"                            LEADER
" ------------------------------------------------------------
let mapleader      = " "
let maplocalleader = " "

"marks
let valid_mark_chars =
            \ "abcdefghijklmnopqrstuvwxyz" .
            \ "ABCDEFGHIJKLMNOPQRSTUVWXYZ" .
            \ "[]<>"
for i in range(56)
    let char = valid_mark_chars[i]
    exec "nnoremap <Leader>m" . char . " m" . char
endfor
unlet valid_mark_chars


"tab related.
"Personally, I use tab more often.
"So tabs need just 2 keystokes
nnoremap <Leader>n gt
noremap  <Leader>t gT


" ------------------------------------------------------------
"                     LANGUAGE SPECIFIC         
" ------------------------------------------------------------

"--------------------------  LSP  ----------------------------
function LSPBindings()
    if has_key(g:LanguageClient_serverCommands, &l:filetype)
        nnoremap <LocalLeader>t :call LanguageClient#textDocument_hover()<CR>
        nnoremap gd :call LanguageClient#textDocument_definition()<CR>
    endif
endfunction

autocmd FileType * call LSPBindings()


"-------------------------- OCaml ----------------------------
"the default ocaml map controdicts that of LSP
let g:no_ocaml_maps = 1



"--------------------------- Coq -----------------------------
function EnterCoqMode()
    nnoremap <buffer> <silent> r :CoqBack<CR>
    nnoremap <buffer> <silent> h :CoqNext<CR>
    nnoremap <buffer> <silent> <Return> :CoqToCursor<CR>
    nnoremap <buffer> <silent> <Esc> :call QuitCoqMode()<CR>
endfunction

function QuitCoqMode()
    nunmap <buffer> r
    nunmap <buffer> h
    nunmap <buffer> <Return>
    nunmap <buffer> <Esc>
endfunction

function CoqBindings()
    nnoremap <silent> <Leader>cr :CoqBack<CR>
    nnoremap <silent> <Leader>ch :CoqNext<CR>
    nnoremap <silent> <Leader>cc :call EnterCoqMode()<CR>
    nnoremap <silent> <Leader>c<Return> :CoqToCursor<CR>
endfunction

autocmd Filetype coq call CoqBindings()

" ------------------------------------------------------------
"                             MISC
" ------------------------------------------------------------
inoremap <c-o> <c-x><c-o>

cnoremap w!! w suda://%<CR>
