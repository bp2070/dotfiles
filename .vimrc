#plugins minibufexplorer nerdtree/commandT snipmate
#colorscheme mustang

syntax on
colorscheme slate
set number
set smartindent 
set wrap linebreak
set display=lastline
let &showbreak="\u21aa"
set tabstop=4
set shiftwidth=4
set expandtab

"GUI settings
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right scrollbar
set gfn=Droid\ Sans\ Mono\ 11

"LaTex Settings
au BufEnter *.tex colorscheme desert

"key mappings
nnoremap j gj
nnoremap k gk
map <F2> :NERDTreeToggle<CR>
