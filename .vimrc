syntax on
colorscheme slate
set number
set smartindent 
set wrap!
set tabstop=4
set shiftwidth=4
set expandtab
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right scrollbar

map <F2> :NERDTreeToggle<CR>

au BufEnter *.tex set wrap
au BufEnter *.tex set linebreak
au BufEnter *.tex set display=lastline
au BufEnter *.tex colorscheme desert
