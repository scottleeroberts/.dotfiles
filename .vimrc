set nocompatible 
au FileType * setlocal ai sw=2 sts=2 et
let mapleader = "\<Space>" 

call plug#begin('~/.vim/plugged')
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-endwise'
Plug 'rking/ag.vim'
Plug 'itchyny/lightline.vim'
Plug 'slim-template/vim-slim'
Plug 'ap/vim-buftabline'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-rails'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Townk/vim-autoclose'
call plug#end()

filetype plugin indent on
syntax on
set guifont=meslo
set gdefault
set encoding=utf-8
set colorcolumn=80
set encoding=utf-8
set fileencoding=utf-8
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set laststatus=2 " Always show last status
set nowrap
set number
set relativenumber
set ruler " Show cursor position
set scrolloff=1 " Always show at least one line above and below cursor
set showcmd " Show partially typed commands
set showmatch " Matches () etc
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set visualbell " Flash the cursor on error instead of beeping
set wildmenu " Show menu options for completion
set hidden
set mouse=a
set splitright
set backspace=indent,eol,start

" Theme
colorscheme onedark 

" Key Mappings
inoremap jj <Esc>
inoremap <Esc> <noop>
map ; :

nnoremap <CR> :noh<CR><CR>
nnoremap <leader>[ :bprev<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>/ :Files<CR>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

set rtp+=~/.fzf

" Searching
set hlsearch
set ignorecase
set smartcase " Only search upcase if provided with capital letter
set gdefault " Assume /g flag on :%s to replace all matches on line
set incsearch " Search as typing

" Highlight current line in active pane only
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Highlight current column in active pane only
augroup CursorColumn
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorcolumn
augroup END
