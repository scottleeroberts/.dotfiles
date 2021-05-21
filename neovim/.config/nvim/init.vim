au FileType * setlocal ai sw=2 sts=2 et
let mapleader = "\<Space>"
filetype plugin indent on
syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'FooSoft/vim-argwrap'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'ap/vim-css-color'
Plug 'benmills/vimux'
Plug 'chrisbra/Recover.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-pug'
Plug 'owozsh/amora'
Plug 'junegunn/fzf.vim', { 'commit': '0fe8e198a3a501b54dbc4f9587526c097599f95a' }
Plug 'kchmck/vim-coffee-script'
Plug 'kthibodeaux/tig.vim'
Plug 'lisinge/vim-slim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'slm-lang/vim-slm'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vim-ruby/vim-ruby'
Plug 'voldikss/vim-floaterm'
call plug#end()

" Don't show the startup message
set termguicolors
set backspace=indent,eol,start
set backupdir=~/.config/nvim/tmp
set clipboard=unnamedplus
set colorcolumn=80
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
set shortmess=atc
set showcmd " Show partially typed commands
set showmatch " Matches () etc
set signcolumn=yes
set splitbelow
set splitright
set termencoding=utf-8
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set undodir=~/.config/nvim/undodir
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set updatetime=300
set visualbell " Flash the cursor on error instead of beeping
set wildmenu " Show menu options for completion

" Searching
set hlsearch
set ignorecase
set smartcase " Only search upcase if provided with capital letter
set gdefault " Assume /g flag on :%s to replace all matches on line
set incsearch " Search as typing

"theme
colorscheme amora
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
autocmd VimEnter * hi Normal ctermbg=none

"quickscope
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" status line configuration
set statusline=
set statusline+=\ %F
set statusline+=\ %m
set statusline+=\ %{coc#status()}
set statusline+=%r
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %l:%c

"Statusline changes color based on mode
au InsertEnter * hi StatusLine term=reverse ctermfg=0 ctermbg=2
au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=4

" Key Mappings
inoremap jj <Esc>

noremap <c-z> <Nop>
nnoremap <CR> :noh<CR><CR>
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$ " split line
nnoremap <c-p> A <esc>p
nnoremap <leader>d :bd<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :update<CR>
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
nnoremap <leader>z zR
nnoremap n nzz
nnoremap N Nzz
nnoremap <leader>( :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <leader>) :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>

nmap <leader>h <Plug>GitGoBack

nnoremap <leader>f :tab new<CR>
nnoremap <leader><CR> gt
noremap  <leader>tt  :FloatermToggle<CR>
tnoremap <leader>tt  <C-\><C-n>:FloatermToggle<CR>


let g:floaterm_position = 'center'

"paste on line below the cursor
map ,p :pu<CR>

"make vim-surround do words more easily
map sw ysiw

map Y y$

" Resizing splits
nnoremap <silent> <Up> :resize -2<CR>
nnoremap <silent> <Down> :resize +2<CR>
nnoremap <silent> <Left> :vertical resize +2<CR>
nnoremap <silent> <Right> :vertical resize -2<CR>

" Close the buffer and reuse the window for an existing buffer
nnoremap <leader>/ :Files<CR>

"format entire file
nnoremap <leader><tab> mtgg=G`t

map <C-n> :NERDTreeFind<CR>

" source $MYVIMRC reloads the saved $MYVIMRC
nnoremap <Leader>s :source $MYVIMRC<CR>

"tig and git mappings
nmap <leader>vc <Plug>TigFileHistory
nmap <leader>vv <Plug>TigBlame
nmap <leader>vb <Plug>TigLatestCommitForLine
nmap <leader>vx :Commits<CR>
nmap <leader>vz :GFiles?<CR>

set rtp+=~/.fzf

command! FZF FloatermNew fzf
command! -bang -nargs=* Find
    \ call fzf#vim#grep(
    \'rg --column  --no-heading --smart-case  --hidden --follow -g "!.git/*" --color "always" '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview('right:60%')
      \ )

" Highlight current column in active pane only
augroup CursorColumn
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorcolumn
augroup END

" https://github.com/vim-ruby/vim-ruby/blob/master/doc/vim-ruby.txt#L133
let g:ruby_indent_block_style = 'do'

let NERDTreeMinimalUI = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ "Modified"  : "✹",
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
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
highlight! link NERDTreeFlags NERDTreeDir

"Open to last position in file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"abbreviations
iabbr pry ::Kernel.binding.pry

"allow transparency of backgrounds
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
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
autocmd FileType vue setlocal commentstring=//\ %s

" Vue `gf` for components
set suffixesadd=.vue
set path=.,app/javascript/**

let g:closetag_filetypes = 'html,vue,xhtml'
let g:closetag_xhtml_filetypes = 'html,vue,xhtml'

let g:vue_pre_processors = 'detect_on_enter'

nmap <leader>lq <Plug>UseQwertyNavigation
nmap <leader>lc <Plug>UseColemakNavigation

let g:coc_snippet_prev = '<c-p>'
let g:coc_snippet_next = '<c-n>'

let g:coc_global_extensions = [
      \'coc-css',
      \'coc-eslint',
      \'coc-html',
      \'coc-json',
      \'coc-snippets',
      \'coc-solargraph',
      \'coc-tsserver',
      \'coc-vetur',
      \'coc-yaml',
      \]
" }}}


