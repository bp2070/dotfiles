"plugins minibufexplorer nerdtree/commandT snipmate
"colorscheme mustang

"Misc settings
set nocompatible
set hidden
set nobackup
set noswapfile

"Syntax highlighting
syntax on
set t_Co=256
colorscheme mustang         " use slate if mustang not installed

"Text settings
set autoindent
set smartindent 
set nowrap
set softtabstop=4          
set shiftwidth=4           
set tabstop=4
set expandtab               " expand tabs to spaces
set nosmarttab              " no tabs
set formatoptions+=n        " support for numbered/bullet lists
"set textwidth=80           " wrap at 80 chars by default
set virtualedit=block       " allow virtual edit in visual block ..

"GUI settings
set guioptions-=m           " remove menu bar
set guioptions-=T           " remove toolbar
set guioptions-=r           " remove right scrollbar
set gfn=Droid\ Sans\ Mono\ 11

"LaTex Settings
au BufEnter *.tex colorscheme desert
au BufEnter *.tex set wrap linebreak
au BufEnter *.tex set display=lastline
au BufEnter *.tex let &showbreak="\u21aa"

"key mappings
nnoremap ; :
nnoremap j gj
nnoremap k gk
map <F2> :NERDTreeToggle<CR>

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set number                 " line numbers
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling


" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set incsearch              " do incremental searching
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set nohlsearch             " don't highlight searches
set visualbell             " shut the fuck up


" ---------------------------------------------------------------------------
"  Strip all trailing whitespace in file
" ---------------------------------------------------------------------------

function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>


