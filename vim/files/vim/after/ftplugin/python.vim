" ft=python

set foldmethod=indent

" only one indentation level when breaking parentheses
let g:pyindent_open_paren=shiftwidth()

" search for all functions and class definitions
nnoremap <Leader>f :L \(def\\|class\) <CR>
