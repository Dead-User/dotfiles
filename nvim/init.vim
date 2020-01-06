
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

"dein config
let g:dein_install_dir = '~/.local/share/nvim/dein'
execute "set rtp+=" . g:dein_install_dir . '/repos/github.com/Shougo/dein.vim'

if dein#load_state(g:dein_install_dir)
  call dein#begin(g:dein_install_dir)
"plugins
  call dein#add(g:dein_install_dir . '/repos/github.com/Shougo/dein.vim')

  call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh'})
  call dein#add('dense-analysis/ale')

  call dein#add('mbbill/fencview')
  call dein#add('lambdalisue/suda.vim')
  call dein#add('Yggdroot/indentLine')
  call dein#add(g:dein_install_dir . '/local_plugins/vim-fcitx')

  let g:opamshare = substitute(system('opam config var share'), '\n$', '', '')
  call dein#add(g:opamshare . '/merlin/vim', { 'on_ft': 'ocaml' })

  call dein#end()
  call dein#save_state()
endif

"language servers
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \}

function LSP_Omni_Complete()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    set omnifunc=LanguageClient#complete
  endif
endfunction

autocmd FileType * call LSP_Omni_Complete()

let g:LanguageClient_diagnosticsEnable = 0

set encoding=utf-8 fileencodings=utf-8,sjis-8,cp936
set fileformats=unix,dos

let loaded_matchparen = 1


"fencview
let g:fencview_autodetect=1
let g:fencview_checklines=20

"indent line
let g:indentLine_conceallevel = 1
let g:indentLine_setColors = 0
let g:indentLine_char = '|'
let g:indentLine_enabled = 0


"ale
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 0



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

"repl setup
function! Run()
  if !exists("s:run_cmd")
    if &l:filetype == 'haskell'
      let s:run_cmd = 'ghci'
    elseif filereadable('./Cargo.toml')
      let s:run_cmd = 'cargo run'
    else
      let s:run_cmd = &l:filetype 
    endif
  endif
  call jobstart(['new-terminal', '--exec', 'run-prog', s:run_cmd, expand('%:p')])
endfunction

"compile setup
function! Make()
  if !exists('s:make_cmd')
    if filereadable('./all.do')
      let s:make_cmd = 'redo'
    elseif filereadable('./Makefile')
      let s:make_cmd = 'make'
    elseif filereadable('dune')
      let s:make_cmd = 'dune build'
    elseif filereadable('Cargo.toml')
      let s:make_cmd = 'cargo build'
    else
      let s:make_cmd = 'echo don\'t know how to make'
    endif
  endif
  "[popup] a tiny script used to interact with the window manager
  call jobstart(['new-terminal', '--exec', 'run-prog', s:make_cmd])
endfunction

function! Test()
  if !exists('s:test_cmd')
    if filereadable('./dune')
      let s:test_cmd = 'dune runtest'
    elseif filereadable('./test.sh')
      let s:test_cmd = './test.sh'
    else
      let s:test_cmd = 'echo don\'t know how to test'
    endif
  endif
  call jobstart(['new-terminal', '--exec', 'run-prog', s:test_cmd])
endfunction

function! Check()
  if !exists('s:check_cmd')
    if filereadable('Cargo.toml')
      let s:check_cmd = 'cargo check'
    else
      let s:check_cmd = 'echo don\'t know how to check'
    endif
  endif
  call jobstart(['new-terminal', '--exec', 'run-prog', s:check_cmd])
endfunction

"popup terminal, better than vim's own window system.
"after all, why not use a real window manager?
function! Term()
  " call jobstart(['new-terminal', '--popup', '--no-cmd'])
  call jobstart(['new-terminal'])
endfunction

source ~/.config/nvim/keymap.vim
source ~/.config/nvim/statusLine.vim

