au FileType * setlocal ai sw=2 sts=2 et
let mapleader = "\<Space>"

filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-endwise'
Plug 'rking/ag.vim'
Plug 'slim-template/vim-slim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'cyphactor/vim-open-alternate'
Plug 'chriskempson/base16-vim'
Plug 'thoughtbot/vim-rspec'
Plug 'benmills/vimux'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'chrisbra/vim-diff-enhanced'
Plug 'fishbullet/deoplete-ruby'
Plug 'junegunn/vim-peekaboo'
Plug 'pangloss/vim-javascript'
Plug 'ecomba/vim-ruby-refactoring'
call plug#end()

" Don't show the startup message
set shortmess=I

set statusline+=%F
set termencoding=utf-8
set gdefault
set encoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set backupdir=~/.config/nvim/tmp
set directory=~/.config/nvim/tmp
set undodir=~/.config/nvim/undodir
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

"highlight at column 80 only if the line exceeds
highlight ColorColumn ctermbg=red ctermfg=black
call matchadd('ColorColumn', '\%81v\s*\S', 100)

" Theme stuff
set background=dark
let base16colorspace=256
colorscheme base16-ocean

let g:airline_theme='base16'
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#checks = []
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Key Mappings
inoremap jj <Esc>
inoremap jw <Esc>:w<cr>
inoremap <Esc> <noop>
map ; :

nnoremap <CR> :noh<CR><CR>
nnoremap <leader>[ :bprev<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>/ :Files<CR>
nnoremap <leader>l :BCommits<CR>
nnoremap <leader>g <C-]>
nnoremap <leader>b :Buffer<CR>
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
map <Leader>a :call RunAllSpecs()<CR>

"Rails file navigation
nnoremap <leader>c :Econtroller<CR>
nnoremap <leader>m :Emodel<CR>
nnoremap <leader>v :Eview<CR>
nnoremap <leader>u :Eunittest<CR>
" Resizing splits
nnoremap <silent> <Up> :resize -2<CR>
nnoremap <silent> <Down> :resize +2<CR>
nnoremap <silent> <Left> :vertical resize +2<CR>
nnoremap <silent> <Right> :vertical resize -2<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Close the buffer and reuse the window for an existing buffer
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

"format entire file
nnoremap <leader><tab> mtgg=G`t

map <C-n> :NERDTreeFind<CR>

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

" https://github.com/vim-ruby/vim-ruby/blob/master/doc/vim-ruby.txt#L133
let g:ruby_indent_block_style = 'do'

autocmd! BufWritePost,BufRead * Neomake

let g:deoplete#enable_at_startup = 1

" Default peekaboo window
 let g:peekaboo_window = 'vertical botright 30new'

 " Strip trailing whitespace before saving
au BufWritePre * :call <SID>StripWhite()
fun! <SID>StripWhite()
  norm md
  %s/[ \t]\+$//ge
  %s!^\( \+\)\t!\=StrRepeat("\t", 1 + strlen(submatch(1)) / 8)!ge
  norm `d
endfun

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

function! AskQuit (msg, options, quit_option)
  if confirm(a:msg, a:options) == a:quit_option
    exit
  endif
endfunction

function! EnsureDirExists ()
  let required_dir = expand("%:h")
  if !isdirectory(required_dir)
    call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
          \       "&Create it\nor &Quit?", 2)

    try
      call mkdir( required_dir, 'p' )
    catch
      call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
    endtry
  endif
endfunction

augroup AutoMkdir
  autocmd!
  autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

"Boiler configuration
" Ruby file templates {{{
function BoilerBuilder()
  if filereadable("boiler") == 1
    if filereadable(@%) == 0
      read !ruby boiler %
      norm ggdd
    elseif line('$') == 1 && col('$') == 1
      read !ruby boiler %
      norm ggdd
    endif
  endif
endfunction
au BufNewFile,BufReadPost *.rb :call BoilerBuilder()
" }}}

"Tags
set tags+=TAGS,gems.tags
au BufWritePost *.rb :call jobstart('ctags')
