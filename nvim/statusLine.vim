
set statusline =%#StatusLine# "color
set statusline+=%f            "file name
set statusline+=%r:           "read-only flag
set statusline+=\ %L          "line count
set statusline+=\ lines
set statusline+=%=            "end of left section

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=            "end of middle section

set statusline+=<%B>          "hex code of cursor char
set statusline+=\ %5l,\ %c    "current line and column
set statusline+=\ \ [nvim]%*


