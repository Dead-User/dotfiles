


let mapleader=" "
let maplocalleader=" "

"all about arrow keys and browsing
"I use a custom keyboard layout other than QWERTY, don't copy this 
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




nnoremap <leader>s :%s/
nnoremap <leader>dm :delmarks

"reverse ` and ' since the former is more useful
nnoremap ` '
nnoremap ' `

"cancelling highlight
noremap <esc> :nohl<CR>

"omni completion
inoremap <C-o> <C-x><C-o>


"keymaps for custom functions
cnoremap run call Run()
cnoremap make call Make()
cnoremap test call Test()
cnoremap check call Check()
cnoremap term call Term()




"plugin specific maps
cnoremap w!! w suda://%<CR>


function LSP_Keymaps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
   nnoremap <leader>t :call LanguageClient_textDocument_hover()<CR>
   nnoremap <leader>gd :call LanguageClient_textDocument_deifinition()<CR>
  endif
endfunction

autocmd FileType * call LSP_Keymaps()

