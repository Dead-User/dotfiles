
"-------------------------------------------------------------
"                            MISC 
"-------------------------------------------------------------
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

let g:python3_host_prog = '/usr/bin/python3'

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix

filetype on
filetype indent on
filetype plugin on

set shiftwidth=4
set expandtab
set number
set nobackup


"-------------------------------------------------------------
"                         APPEARANCE 
"-------------------------------------------------------------
if &t_Co > 2 || has("gui_running")
  set guioptions-=m
  set guioptions-=T
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

set termguicolors

"-------------------------------------------------------------
"                        PLUGIN SPECIFIC 
"-------------------------------------------------------------
"LanguageClient-neovim
let g:LanguageClient_serverCommands = {
            \ "rust": ["rls"],
            \ "ocaml": ["ocamllsp"]
            \ }

function LSPSetupHook()
    if has_key(g:LanguageClient_serverCommands, &l:filetype)
        set omnifunc=LanguageClient#complete
    endif
endfunction

autocmd FileType * call LSPSetupHook()


