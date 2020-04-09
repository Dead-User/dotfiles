
call plug#begin('~/.local/share/vim-plug')
Plug 'autozimu/LanguageClient-neovim', 
            \ {'branch': 'next', 'do': 'bash install.sh' }
Plug 'dense-analysis/ale'

Plug 'whonore/Coqtail'
call plug#end()
