
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

exec expand("source <sfile>:h/packages.vim")
exec expand("source <sfile>:h/key-binding.vim") 
exec expand("source <sfile>:h/user-options.vim")
exec expand("source <sfile>:h/user-commands.vim")
exec expand("source <sfile>:h/status-line.vim")
