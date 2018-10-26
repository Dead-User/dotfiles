"auto input method swapping for ibus
if !exists("g:method")
  let g:method = "xkb:us::eng"
endif

function IbusRunning()
  let addr = system("ibus address")
  return !(addr ==? "(none)")
endfunction

function! GetInputMethod()
  return (system("ibus engine"))
endfunction

function! IsDefault(m)
  return a:m ==? "xkb:us::eng"
endfunction

function! ToNormal()
  if IbusRunning()
    let m = GetInputMethod()
    if !IsDefault(m)
      let g:method = m
      call system("ibus engine xkb:us::eng")
      return
    endif
  endif
endfunction

function! ToInsert()
  call system("ibus engine " . g:method)
endfunction

inoremap <esc> <esc>:call ToNormal()<enter>
nnoremap i :call ToInsert()<enter>i
