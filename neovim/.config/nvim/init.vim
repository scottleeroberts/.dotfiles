au FileType * setlocal ai sw=2 sts=2 et
let mapleader = "\<Space>"

filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Townk/vim-autoclose'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'benmills/vimux'
Plug 'chrisbra/Recover.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'fishbullet/deoplete-ruby'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'kchmck/vim-coffee-script'
Plug 'kthibodeaux/tig.vim'
Plug 'kthibodeaux/pull-review'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'slim-template/vim-slim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
call plug#end()

" Don't show the startup message
set backspace=indent,eol,start
set backupdir=~/.config/nvim/tmp
set clipboard=unnamedplus
set directory=~/.config/nvim/tmp
set encoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set gdefault
set hidden
set laststatus=2 " Always show last status
set ls=2
set mouse=a
set nowrap
set number
set relativenumber
set ruler " Show cursor position
set scrolloff=1 " Always show at least one line above and below cursor
set shortmess=I
set showcmd " Show partially typed commands
set showmatch " Matches () etc
set splitright
set splitbelow
set termencoding=utf-8
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set undodir=~/.config/nvim/undodir
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set visualbell " Flash the cursor on error instead of beeping
set wildmenu " Show menu options for completion
set colorcolumn=80
" Searching
set hlsearch
set ignorecase
set smartcase " Only search upcase if provided with capital letter
set gdefault " Assume /g flag on :%s to replace all matches on line
set incsearch " Search as typing


" Theme stuff
set background=dark
let base16colorspace=256
colorscheme base16-ocean

" bufftabline settings
let g:buftabline_indicators = 1
let g:buftabline_separators = 1
hi! link BufTabLineActive Comment

" status line configuration
set statusline=
set statusline+=\ %F
set statusline+=\ %m
set statusline+=%r
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %l:%c
"Statusline changes color based on mode
au InsertEnter * hi StatusLine term=reverse ctermfg=0 ctermbg=2
au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=4

"Rails open associated spec files or vice versa
function! RailsOpenAltCommand(path, vim_command)
  if a:path =~ "spec/"
    let l:alternate = substitute(a:path, "spec/", "app/", "")
    let l:alternate = substitute(l:alternate, "_spec", "", "")
  elseif a:path =~ "app/"
    let l:alternate = substitute(a:path, "app/", "spec/", "")
    let l:alternate = substitute(l:alternate, ".rb", "_spec.rb", "")
  endif

  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Key Mappings
inoremap jj <Esc>
inoremap jw <Esc>:w<cr>
inoremap <Esc> <noop>
map ; :

nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$ " split line
nnoremap <CR> :noh<CR><CR>
nnoremap <leader>[ :bprev<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>g <C-]>
nnoremap <leader>b :Buffer<CR>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
nnoremap <leader>. :call RailsOpenAltCommand(expand('%'), ':vsplit')<cr>
nnoremap <leader> :w<CR>
nnoremap <leader>ff :Find<space>
nnoremap <leader>fs :Find<space><c-R><c-W><CR>
nnoremap <leader>fv :vs<CR>:Find<space>
nnoremap <leader>mi :edit db/migrate<CR>G


" RSpec.vim mappings
let g:rspec_command = 'call VimuxRunCommand("bundle exec rspec {spec}\n")'
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rr :call RunNearestSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

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

" Close the buffer and reuse the window for an existing buffer
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

"format entire file
nnoremap <leader><tab> mtgg=G`t

map <C-n> :NERDTreeFind<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

"tig and git mappings
nnoremap <leader>vc :silent TigFileHistory<CR>
nnoremap <leader>vv :silent TigLatestCommitForLine<CR>
nnoremap <leader>vb :silent TigBlame<CR>

set rtp+=~/.fzf

nnoremap <leader>/ :Files<CR>
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

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

let g:deoplete#enable_at_startup = 1

" Default peekaboo window
 let g:peekaboo_window = 'vertical botright 30new'

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
au BufNewFile,BufReadPost *.rb silent! :call BoilerBuilder()
" }}}

"Tags
au BufWritePost *.rb :call jobstart('ripper-tags -R --exclude spec/ --exclude db/')

"ripgrep
command! -bang -nargs=* Find
      \ call fzf#vim#grep(
      \'rg --column --line-number --no-heading --fixed-strings --ignore-case  --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview('up:60%')
      \ )

"Open to last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"abbreviations
iabbr pry ::Kernel.binding.pry
