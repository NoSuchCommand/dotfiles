silent! colorscheme gruvbox
set background=dark

set number
set relativenumber

set nohlsearch
set nowrap

set splitright

set ruler
set laststatus=2

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4

set history=1000
set path+=**
set wildmenu

let g:xml_syntax_folding=1

"let g:HardMode_level = 'wannabe'
"let g:hardtime_default_on = 1
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

"autocmd VimEnter,FilterWritePre * if &diff | execute 'windo set wrap cc=' | endif
"autocmd VimEnter,FilterWritePre * if &diff | color industry | endif

set noshowmatch
