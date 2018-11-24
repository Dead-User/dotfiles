" Vim color file

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "cc"

hi Normal guifg=#EFDFEF guibg=NONE

"line numbers
hi LineNr guifg=#FFFFFF

"comment
hi Comment guifg=#A000A0
hi link SpecialComment Comment

"data types
hi Boolean guifg=#00E0FF
hi Number guifg=#00E0FF
hi Character guifg=#F0F030
hi String guifg=#F0F030
hi Constant guifg=#A0F030
hi Identifier guifg=#EFDFEF

"special characters
hi Delimiter guifg=#FF4000 gui=bold
hi SpecialChar guifg=#00A0FF gui=bold
hi Operator guifg=#A0FF00 gui=bold

"special labels
hi Function guifg=#00F000 
hi PreProc guifg=#00F000
hi Type guifg=#FF8000
hi Keyword guifg=#FF2020 gui=bold
hi Statement guifg=#FF2020 gui=bold

hi Structure guifg=#FFA0FF

"mark relative
hi MatchParen guifg=#202020 guibg=#00FF00 gui=bold

"error
hi Error guifg=#E0E0E0 guibg=#C00000

"status line
hi StatusLine guifg=#EBE4DA guibg=#404040 gui=bold

set background=dark

" vim: sw=2
