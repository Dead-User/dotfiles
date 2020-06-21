
" 0 -> not in coq mode
" 1 -> in coq mode
let g:coq_mode_state = 0

function EnterCoqMode()
    if g:coq_mode_state == 0
        nnoremap <buffer> <silent> r :CoqBack<CR>
        nnoremap <buffer> <silent> h :CoqNext<CR>
        nnoremap <buffer> <silent> <Return> :CoqToCursor<CR>
        nnoremap <buffer> <silent> <Esc> :call QuitCoqMode()<CR>

        let g:coq_mode_state = 1
    endif
endfunction

function QuitCoqMode()
    if g:coq_mode_state == 1
        nunmap <buffer> r
        nunmap <buffer> h
        nunmap <buffer> <Return>
        nunmap <buffer> <Esc>

        let g:coq_mode_state = 0
    endif
endfunction

nnoremap <silent> <Leader>cr :CoqBack<CR>
nnoremap <silent> <Leader>ch :CoqNext<CR>
nnoremap <silent> <Leader>c<Return> :CoqToCursor<CR>
nnoremap <silent> <Leader>cc :call EnterCoqMode()<CR>

autocmd InsertEnter call QuitCoqMode()


