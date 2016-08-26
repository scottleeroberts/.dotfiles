set nocompatible 
au FileType * setlocal ai sw=2 sts=2 et
let mapleader = "\<Space>" 

call plug#begin('~/.vim/plugged')
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-endwise'
Plug 'rking/ag.vim'
Plug 'slim-template/vim-slim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-buftabline'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'cyphactor/vim-open-alternate'
Plug 'chriskempson/base16-vim'
Plug 'thoughtbot/vim-rspec'
Plug 'benmills/vimux'
call plug#end()

filetype plugin indent on
syntax on
set guifont=Inconsolata\ for\ Powerline:h18
set statusline+=%F
set term=xterm-256color
set termencoding=utf-8
set clipboard=unnamed 
set gdefault
set encoding=utf-8
set colorcolumn=80
set encoding=utf-8
set fileencoding=utf-8
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp
set ls=2
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
set undofile

" Theme
set background=dark
let base16colorspace=256
colorscheme base16-ocean

let g:airline_theme='murmur'
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#checks = []

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
nnoremap <leader> :w<CR>

nnoremap <leader>. :vs<CR>:OpenAlternate<CR>

" RSpec.vim mappings
let g:rspec_command = 'call VimuxRunCommand("bundle exec rspec {spec}\n")'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"Rails file navigation
nnoremap <leader>c :Econtroller<CR>
nnoremap <leader>m :Emodel<CR>
nnoremap <leader>v :Eview<CR>
nnoremap <leader>s :Espec<CR>
nnoremap <leader>u :Eunittest<CR>
" Resizing splits
nnoremap <silent> <Up> :resize -2<CR>
nnoremap <silent> <Down> :resize +2<CR>
nnoremap <silent> <Left> :vertical resize +2<CR>
nnoremap <silent> <Right> :vertical resize -2<CR>

" Close the buffer and reuse the window for an existing buffer
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

"format entire file
nnoremap <leader><tab> mtgg=G`t

" Always assume paste mode when pasting from system clipboard
noremap <silent> <C-r>* <C-o>:setl paste<CR><C-r>*<C-o>:setl nopaste<CR>

map <C-n> :NERDTreeFind<CR>

set rtp+=~/.fzf

" Searching
set hlsearch
set ignorecase
set smartcase " Only search upcase if provided with capital letter
set gdefault " Assume /g flag on :%s to replace all matches on line
set incsearch " Search as typing

"copy and pasting
vmap <Leader>y "+y
nmap <Leader>p "+p" 
nmap <Leader>P "+P
nmap <Leader><Leader> V
"jump to the end on paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

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

" copy current file name (relative/absolute) to system clipboard
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>cF :let @*=expand("%:p")<CR>

  " filename       (foo.txt)
  nnoremap <leader>ct :let @*=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
endif

" nerd commenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" https://github.com/vim-ruby/vim-ruby/blob/master/doc/vim-ruby.txt#L133
let g:ruby_indent_block_style = 'do'

