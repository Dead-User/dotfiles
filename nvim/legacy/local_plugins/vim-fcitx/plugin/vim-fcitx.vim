"auto input method swapping for fcitx

if !exists("g:fcitx_state")
  let g:fcitx_state = 0
endif

function! GetState()
  return (system("fcitx-remote"))
endfunction

function! ToNormal()
  let st = GetState()
  let g:fcitx_state = l:st
  if l:st == 2
    call system("fcitx-remote -c")
  endif
endfunction

function! ToInsert()
  if g:fcitx_state == 2
    call system("fcitx-remote -o")
  endif
endfunction

au InsertLeave * call ToNormal()
au InsertEnter * call ToInsert()
