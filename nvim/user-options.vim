
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
        nnoremap <LocalLeader>t :call LanguageClient#textDocument_hover()<CR>
        nnoremap gd :call LanguageClient#textDocument_definition()<CR>
    endif
endfunction

autocmd FileType * call LSPSetupHook()

" ocp-indent specific (installed through opam)
let g:opam_share = substitute(system("opam config var share"), '\n$', '', '')
autocmd FileType ocaml execute "source " . g:opam_share . "/ocp-indent/vim/indent/ocaml.vim"
