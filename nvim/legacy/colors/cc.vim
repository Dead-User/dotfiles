" Vim color file

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "cc"

hi Normal guifg=#FEEEED guibg=NONE

"line numbers
hi LineNr guifg=#FFFFFF

"comment
hi Comment guifg=#606060
hi link SpecialComment Comment

"data types
hi Boolean guifg=#00E0FF
hi Number guifg=#00E0FF
hi Character guifg=#F0F030
hi String guifg=#F0F030
hi Constant guifg=#00E0FF
hi Identifier guifg=#EFDFEF

"special characters
hi Delimiter guifg=#FF4000 gui=bold
hi SpecialChar guifg=#00A0FF gui=bold
hi Operator guifg=#FF2000 gui=bold

"special labels
hi Function guifg=#00F000 
hi PreProc guifg=#00F000
hi Type guifg=#FF8000
hi Keyword guifg=#FF8000 gui=bold
hi Statement guifg=#FF2020 gui=bold

hi Structure guifg=#FFA0FF

"mark relative
hi MatchParen guifg=#202020 guibg=#A0A0A0 gui=bold

"error
hi Error guifg=#E0E0E0 guibg=#C00000

"status line
hi StatusLine guifg=#EBE4DA guibg=#404040 gui=bold

"indent line
hi Conceal guifg=#8B847A guibg=NONE

"complete menu
hi PMenu guifg=#EBE4DA guibg=#404040
hi Search guifg=#FFFFFF guibg=#808080

hi TabLineFill guifg=#404040 guibg=#404040 guibg=None
hi TabLine guifg=#EBE4DA guibg=#404040
hi TabLineSel guifg=#EBE4DA guibg=#202020

set background=dark

" vim: sw=2
