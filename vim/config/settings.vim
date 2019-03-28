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
autocmd FileType yaml setlocal sw=2 sts=2 ts=2 cc= nonu
autocmd VimEnter,FilterWritePre * if &diff | execute 'windo set wrap cc=' | endif
autocmd VimEnter,FilterWritePre * if &diff | color industry | endif
