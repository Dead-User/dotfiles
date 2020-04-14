
"completion
set omnifunc=LanguageClient#complete
"bindings
nnoremap <LocalLeader>t :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
