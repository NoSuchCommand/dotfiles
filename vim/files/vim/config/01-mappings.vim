" perso

" Maximize/Equalize splits
nnoremap <Leader>+ <C-w>\|<C-w>_
nnoremap <Leader>= <C-w>=

" Navigating folds
nnoremap ² zk
nnoremap & zj
" Opening/closin folds
nnoremap ! za
nnoremap ù zA

" Moving around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Expected yank until eol
nnoremap Y y$

" Navigating diff chunks
nnoremap <expr> )c &diff ? ']c' : ')c'
nnoremap <expr> àc &diff ? '[c' : 'àc'

" Toggle mouse
nnoremap <F1> :exec &mouse != "" ? "set mouse=" : "set mouse=a"<CR>
" Toggle wrapping
nnoremap <F2> :set wrap!<CR>
" Toggle hlsearch
nnoremap <F3> :set hlsearch!<CR>
" Toggle list
nnoremap <F4> :set list!<CR>
" Toggle cursorcolumn
nnoremap <F5> :set cursorcolumn!<CR>

" Open file under cursor
nnoremap <Leader>gf :e %:p:h:t/<cfile><CR>

" Center cursor
" when navigating search results
nnoremap n nzzzv
nnoremap N Nzzzv
" when moving half-pages
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Do not move cursor when merging lines
nnoremap J mzJ`z

" Jump points
nnoremap <expr> k (v:count > 3 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 3 ? "m'" . v:count : "") . 'j'

" Undo points
inoremap , ,<C-g>u
inoremap . .<C-g>u

" Moving lines around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==i
inoremap <C-k> <esc>:m .-2<CR>==i
nnoremap <Leader>j :m .+1<CR>==
nnoremap <Leader>k :m .-2<CR>==

" vim-asterisk
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

" fzf.vim
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>p :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" NERDTree
nnoremap <Leader>n :NERDTreeToggle %<CR>

" floatterm
nnoremap <silent> <C-F8>  :FloatermKill<CR>:FloatermNext<CR>
tnoremap <silent> <C-F8>  <C-\><C-n>:FloatermKill<CR>:FloatermNext<CR>
nnoremap <silent> <C-F9>  :FloatermNew<CR>
tnoremap <silent> <C-F9>  <C-\><C-n>:FloatermNew<CR>
nnoremap <silent> <C-F10>  :FloatermPrev<CR>
tnoremap <silent> <C-F10>  <C-\><C-n>:FloatermPrev<CR>
nnoremap <silent> <C-F11>  :FloatermNext<CR>
tnoremap <silent> <C-F11>  <C-\><C-n>:FloatermNext<CR>
nnoremap <silent> <C-F12> :FloatermToggle<CR>
tnoremap <silent> <C-F12> <C-\><C-n>:FloatermToggle<CR>

" coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <F6> :CocDiagnostics<CR>
nmap <silent> àg <Plug>(coc-diagnostic-prev)
nmap <silent> )g <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
