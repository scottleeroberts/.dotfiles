au FileType * setlocal ai sw=2 sts=2 et
let mapleader = "\<Space>"

filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'FooSoft/vim-argwrap'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'benmills/vimux'
Plug 'chrisbra/Recover.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'fishbullet/deoplete-ruby'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'kchmck/vim-coffee-script'
Plug 'kthibodeaux/pull-review'
Plug 'kthibodeaux/tig.vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
Plug 'lisinge/vim-slim'
Plug 'andymass/vim-matchup'

call plug#end()

" Don't show the startup message
set backspace=indent,eol,start
set backupdir=~/.config/nvim/tmp
set clipboard=unnamedplus
set directory=~/.config/nvim/tmp
set encoding=UTF-8
set fileencoding=UTF-8
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
set shortmess=at

" Searching
set hlsearch
set smartcase " Only search upcase if provided with capital letter
set gdefault " Assume /g flag on :%s to replace all matches on line
set incsearch " Search as typing

" Theme stuff
set background=dark
let base16colorspace=256
colorscheme base16-nord

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

" Key Mappings
inoremap jj <Esc>:w<cr>

noremap <c-z> <Nop>
nnoremap <cr> @q
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$ " split line
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
nnoremap <leader>ff :Find<space>
nnoremap <leader>fs :Find<space><c-R><c-W><CR>
nnoremap <leader>fv :vs<CR>:Find<space>
nnoremap <leader>mi :edit db/migrate<CR>G
nnoremap <leader>o :vs<CR>
nnoremap <leader>i :sp<CR>
nnoremap <leader>zi <C-w><Bar><C-w>_<cr>
nnoremap <leader>zo <C-w>=

"remap save on ctrl+s
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-q> :q<CR>
inoremap <C-q> <Esc>:q<CR>

"paste on line below the cursor
map ,p :pu<CR>

" RSpec.vim mappings
let g:rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
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

" source $MYVIMRC reloads the saved $MYVIMRC
nnoremap <Leader>s :source $MYVIMRC<CR>

"tig and git mappings
nmap <leader>vc <Plug>TigFileHistory
nmap <leader>vv <Plug>TigBlame
nmap <leader>vb <Plug>TigLatestCommitForLine

set rtp+=~/.fzf

nnoremap <leader>/ :Files<CR>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

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

let NERDTreeMinimalUI = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "*",
      \ "Staged"    : "+",
      \ "Untracked" : "o",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "=",
      \ "Deleted"   : "x",
      \ "Dirty"     : "X",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }
let NERDTreeShowHidden=1
"Tags
au BufWritePost *.rb :call jobstart('sh ~/.dotfiles/bin/run_tags')

"ripgrep
command! -bang -nargs=* Find
      \ call fzf#vim#grep(
      \'rg --column  --no-heading --fixed-strings --smart-case  --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview('up:60%')
      \ )

let g:fzf_layout = { 'down': '~60%' }

"Open to last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"abbreviations
iabbr pry ::Kernel.binding.pry

" vim-matchup highlight color
:hi MatchParen ctermbg=239

let g:UltiSnipsSnippetDir = '~/.config/nvim/UltiSnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight ALEWarning ctermbg=18 ctermfg=none

"allow transparency of backgrounds
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight ColorColumn ctermbg=235
highlight CursorColumn ctermbg=235
highlight LineNr ctermbg=none
highlight SignColumn ctermbg=none
highlight GitGutterAdd ctermbg=none
highlight GitGutterChange ctermbg=none
highlight GitGutterDelete ctermbg=none
highlight GitGutterChangeDelete ctermbg=none

"auto-pairs configuration
let g:AutoPairsMultilineClose=0

let g:argwrap_padded_braces = '{'
let g:argwrap_tail_comma = 1
nnoremap <silent> <leader>a :ArgWrap<CR>

"New line in commented section is not commented
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
