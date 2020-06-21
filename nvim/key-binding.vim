

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

let g:multi_cursor_start_key           = 'C'
let g:multi_cursor_next_key            = 'C'
let g:multi_cursor_quit_key            = ';'
noremap s :MultipleCursorsFind 


" ------------------------------------------------------------
"                            LEADER
" ------------------------------------------------------------
let mapleader      = " "
let maplocalleader = ","

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
nnoremap <Leader>t gT

"window related
nnoremap <Leader>wr <c-w>k
nnoremap <Leader>wh <c-w>j
nnoremap <Leader>wn <c-w>l
nnoremap <Leader>wt <c-w>h

nnoremap <Leader>w<tab> <c-w><c-w>

" ------------------------------------------------------------
"                             MISC
" ------------------------------------------------------------
inoremap <c-o> <c-x><c-o>

cnoremap w!! w suda://%<CR>
