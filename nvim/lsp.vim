
"completion
set omnifunc=LanguageClient#complete

"diagnostics
let g:LanguageClient_diagnosticsList = 'Location'

"bindings
nnoremap <LocalLeader>t :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
