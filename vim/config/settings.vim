color darkblue
set number
set autoindent
set nohlsearch
set nowrap
set ruler
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set colorcolumn=81
set history=1000
autocmd BufRead,BufNewFile *.md setlocal ft=markdown
autocmd BufRead,BufNewFile *.asciidoc setlocal nonu cc= wrap
autocmd VimEnter,FilterWritePre * if &diff | execute 'windo set wrap' | endif
autocmd VimEnter,FilterWritePre * if &diff | setlocal cc= | endif
autocmd VimEnter,FilterWritePre * if &diff | color industry | endif
