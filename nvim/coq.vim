
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

nnoremap <silent> <Leader>cr :CoqBack<CR>
nnoremap <silent> <Leader>ch :CoqNext<CR>
nnoremap <silent> <Leader>cc :call EnterCoqMode()<CR>
nnoremap <silent> <Leader>c<Return> :CoqToCursor<CR>
