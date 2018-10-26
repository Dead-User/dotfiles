" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

hi Normal ctermfg=231
"line number
hi LineNr ctermfg=219
hi Comment ctermfg=090
hi Keyword ctermfg=130
hi Type ctermfg=231
hi Number ctermfg=027
hi Character ctermfg=202
hi String ctermfg=202
hi Constant ctermfg=082

" Load the syntax highlighting defaults, if it's enabled.
"if exists("syntax_on")
"  syntax reset
"endif

let colors_name = "usr0"

" vim: sw=2
