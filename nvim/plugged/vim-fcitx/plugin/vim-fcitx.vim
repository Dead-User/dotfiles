"auto input method swapping for ibus

if !exists("g:state")
  let g:state = 0
endif

function! GetState()
  return (system("fcitx-remote"))
endfunction

function! ToNormal()
  let st = GetState()
  let g:state = l:st
  if l:st == 2
    call system("fcitx-remote -c")
  endif
endfunction

function! ToInsert()
  if g:state == 2
    call system("fcitx-remote -o")
  endif
endfunction

au InsertLeave * call ToNormal()
au InsertEnter * call ToInsert()
