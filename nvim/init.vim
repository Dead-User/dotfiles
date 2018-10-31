
if &t_Co > 2 || has("gui_running")
  set guioptions-=m
  set guioptions-=T
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  augroup END

else
  set autoindent  " always set autoindenting on
endif

let g:python3_host_prog='/usr/bin/python3'

call plug#begin('~/.config/nvim/plugged')
Plug '~/.config/nvim/plugged/vim-racket'
Plug '~/.config/nvim/plugged/vim-fcitx'
Plug 'mbbill/fencview'
call plug#end()

set encoding=utf-8 fileencodings=utf-8,sjis-8,cp936
set fileformats=unix,dos

let g:fencview_autodetect=1
let g:fencview_checklines=20

filetype on
filetype indent on
filetype plugin on

set shiftwidth=2
set expandtab
set number
set nobackup

set termguicolors
colorscheme cc

let mapleader=" "

cnoremap w!! w !sudo tee %

nnoremap <leader>s :%s/
nnoremap <leader>dm :delmarks

"repl setup
function! Eval()
  if !exists("s:repl_cmd")
    let s:repl_cmd = &l:filetype . " "
  endif
  execute "!" . s:repl_cmd . expand("%")
endfunction
cnoremap repl call Eval()


"reverse ` and ' since the former is more useful
nnoremap ` '
nnoremap ' `

"all about arrow keys
nnoremap t h
nnoremap T b
nnoremap <C-t> ^
vnoremap t h
vnoremap T b
vnoremap <C-t> ^

nnoremap r k
nnoremap R <C-u>
vnoremap r k
vnoremap R <C-u>

nnoremap h j
nnoremap H <C-d>
vnoremap h j
vnoremap H <C-d>

nnoremap n l
nnoremap N e
nnoremap <C-n> $
vnoremap n l
vnoremap N e
vnoremap <C-n> $

"the status line
set statusline =%#StatusLine# "color
set statusline+=%f            "file name
set statusline+=%r:           "read-only flag
set statusline+=\ %L          "line count
set statusline+=\ lines
set statusline+=%=            "end of left section
set statusline+=<%B>          "hex code of cursor char
set statusline+=\ %5l,\ %c    "current line and column
set statusline+=\ \ [nvim]%*
