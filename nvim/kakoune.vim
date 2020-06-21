
function! s:save_region_and_exe(cmd)
    let region_beg = getpos("'<")
    let region_end = getpos("'>")
    call feedkeys(a:cmd, 'n')
    call setpos("'<", region_beg)
    call setpos("'>", region_end)
endfunction

nnoremap t h
nnoremap n l
nnoremap r k
nnoremap h j

vnoremap <silent> t <ESC>hv
vnoremap <silent> n <ESC>lv
vnoremap <silent> r <ESC>kv
vnoremap <silent> h <ESC>jv

nnoremap T vh
nnoremap N vl
nnoremap R vk
nnoremap H vj

vnoremap T h
vnoremap N l
vnoremap R k
vnoremap H j

noremap <c-t> ^
noremap <c-n> $

nnoremap j n
nnoremap k N

vnoremap <silent> d dv
vnoremap <silent> ~ :call <SID>save_region_and_exe('~')<CR>

"This is borrowed from kakoune, meaning `match'
nnoremap m %
vnoremap m <ESC>%
vnoremap M %
