
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
"Plug '~/.config/nvim/plugged/merlin'
Plug 'ocaml/merlin'
"Plug 'autozimu/LanguageClient-neovim', {
"      \'branch': 'next',
"      \'do': 'bash install.sh',
"      \}
Plug 'mbbill/fencview'
Plug 'lambdalisue/suda.vim'
"Plug 'idris-hackers/idris-vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
call plug#end()

"language servers
"let g:LanguageClient_serverCommands = {
"      \'ocaml':['/usr/bin/ocaml-language-server', '--node-ipc'],
"      \}
let loaded_matchparen = 1

set encoding=utf-8 fileencodings=utf-8,sjis-8,cp936
set fileformats=unix,dos

"fencview
let g:fencview_autodetect=1
let g:fencview_checklines=20

"indent line
let g:indentLine_conceallevel = 1
let g:indentLine_setColors = 0
let g:indentLine_char = '|'
let g:indentLine_enabled = 0

"syntastic
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_enable_racket_racket_checker = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

filetype on
filetype indent on
filetype plugin on
let g:no_ocaml_maps = 1

set shiftwidth=2
set expandtab
set number
set nobackup

set termguicolors
colorscheme cc

let mapleader=" "
let maplocalleader=" "

cnoremap w!! w suda://%<CR>

nnoremap <leader>s :%s/
nnoremap <leader>dm :delmarks
"nnoremap <leader>t :call LanguageClient_textDocument_hover()<CR>

inoremap <C-o> <C-x><C-o>

"repl setup
function! Eval()
  if !exists("s:repl_cmd")
    if &l:filetype == 'haskell'
      let s:repl_cmd = 'ghci'
    else
      let s:repl_cmd = &l:filetype 
    endif
  endif
  "[popup] a tiny script used to interact with the window manager
  call jobstart(['new-terminal', '--exec', 'run-prog', s:repl_cmd, expand('%:p')])
endfunction
cnoremap repl call Eval()

"compile setup
function! Make()
  if !exists('s:make_cmd')
    if filereadable('./all.do')
      let s:make_cmd = 'redo'
    elseif filereadable('./Makefile')
      let s:make_cmd = 'make'
    else
      let s:make_cmd = "echo don't know how to make"
    endif
  endif
  "[popup] a tiny script used to interact with the window manager
  call jobstart(['new-terminal', '--exec', 'run-prog', s:make_cmd])
endfunction
cnoremap make call Make()

"popup terminal, better than vim's own window system.
"after all, why not use a real window manager?
function! Term()
  " call jobstart(['new-terminal', '--popup', '--no-cmd'])
  call jobstart(['new-terminal'])
endfunction
cnoremap term call Term()


"reverse ` and ' since the former is more useful
nnoremap ` '
nnoremap ' `

"cancelling highlight
noremap <esc> :nohl<CR>

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

nnoremap j n
nnoremap k N

"the status line
set statusline =%#StatusLine# "color
set statusline+=%f            "file name
set statusline+=%r:           "read-only flag
set statusline+=\ %L          "line count
set statusline+=\ lines
set statusline+=%=            "end of left section

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=            "end of middle section

set statusline+=<%B>          "hex code of cursor char
set statusline+=\ %5l,\ %c    "current line and column
set statusline+=\ \ [nvim]%*


