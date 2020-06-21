

let g:local_plugin_path = expand("<sfile>:h") . "/local_plugins"
call plug#begin('~/.local/share/vim-plug')

"Editing experience enchancement
"Plug 'terryma/vim-multiple-cursors'

"Language specific
Plug 'autozimu/LanguageClient-neovim', 
            \ {'branch': 'next', 'do': 'bash install.sh' }

"Coqtail does not seem to support neovim (yet)
"-- Plug 'whonore/Coqtail', { 'for': 'coq' } 
"This one is probably the start of everything else,
"but is not actively maintained now
"-- Plug 'the-lambda-church/coquille'
Plug 'LumaKernel/coqpit.vim', { 'for': 'coq' }

let g:opam_share = substitute(system("opam config var share"), '\n$', '', '')
exec "Plug '" . g:opam_share . "/ocp-indent/vim', { 'for': 'ocaml' }"

"Misc
Plug 'lambdalisue/suda.vim'
exec "Plug '" . g:local_plugin_path . "/vim-fcitx'"

"Colors
Plug 'nightsense/cosmic_latte'
Plug 'nightsense/stellarized'
Plug 'ayu-theme/ayu-vim'
call plug#end()

let g:LanguageClient_serverCommands = {
            \ "rust": ["rls"],
            \ "ocaml": ["ocamllsp"]
            \ }
