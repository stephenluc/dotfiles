" VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'groenewege/vim-less'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'

" Backend
Plugin 'hynek/vim-python-pep8-indent'

" Color schemes
Plugin 'w0ng/vim-hybrid'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" display settings
set encoding=utf-8 "encoding used for displaying file
" set list " show whitespace as characters
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode

" Formatting
set tabstop=2 
set softtabstop=0 
set expandtab 
set shiftwidth=2
set smarttab

" etc
set nu
set lbr
set mouse=a " Allow scrolling with mouse
set autochdir " Auto change dir to current file
set title
set ttyfast

set grepprg=ack\ -a " ack to search

" Search
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set incsearch " do incremental serach
set smartcase " ...unless capital letters are used

" press F8 to turn the search results highlight off
noremap <F8> :nohl<CR>
inoremap <F8> <Esc>:nohl<CR>a

" NERDTree
map <F1> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ctrlp
let g:ctrlp_map ='<F2>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.tz,*.tar,*/lib/*,*/bin/*,*/djcelery/*,*/docs/*,*/docx-template/*,*/include/*,*/lib/*,*/lib64/*,*/local/*,*/log/*,*/man/*,*/node_modules/*,*/selenium/*,*/__pycache__/*
let g:ctrlp_custom_ignore = '[\/](node_modules|lib|lib64)|\v[\/]\.(git|hg|svn)$'

" Colorscheme
syntax on
let &t_Co = 256
set background=dark
"let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1
colorscheme hybrid

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
