" Vim color file
"
hi clear

let colors_name = "cc"

hi Normal guifg=#EBE4DA guibg=NONE
"line numbers
hi LineNr guifg=#FFFFFF
"data types
hi Boolean guifg=#00E0FF
hi Number guifg=#00E0FF
hi Character guifg=#F0F030
hi String guifg=#F0F030
hi Constant guifg=#A0F030
hi Delimiter guifg=#FF4000 gui=bold
hi SpecialChar guifg=#00A0FF gui=bold
hi Operator guifg=#A0FF00 gui=bold
hi Function guifg=#00F000
hi Keyword guifg=#FF8000 gui=bold
hi Structure guifg=#F0A0F0
"cusor relative
hi MatchParen guifg=#202020 guibg=#E0E0E0
hi Cursor guibg=#808080
"comment
hi Comment guifg=#A000A0

set background=dark

" vim: sw=2
