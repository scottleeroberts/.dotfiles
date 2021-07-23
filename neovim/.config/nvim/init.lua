-------------
-- Aliases --
-------------
local exec = vim.api.nvim_exec
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.opt
local ow = vim.ow

-------------
-- Plugins --
-------------
cmd("call plug#begin('~/.config/nvim/plugged')")
cmd("Plug 'FooSoft/vim-argwrap'")
cmd("Plug 'Xuyuanp/nerdtree-git-plugin'")
cmd("Plug 'airblade/vim-gitgutter'")
cmd("Plug 'alvan/vim-closetag'")
cmd("Plug 'ap/vim-css-color'")
cmd("Plug 'benmills/vimux'")
cmd("Plug 'chrisbra/Recover.vim'")
cmd("Plug 'christoomey/vim-tmux-navigator'")
cmd("Plug 'digitaltoad/vim-pug'")
cmd("Plug 'folke/tokyonight.nvim'")
cmd("Plug 'junegunn/fzf.vim', { 'commit': '0fe8e198a3a501b54dbc4f9587526c097599f95a' }")
cmd("Plug 'kchmck/vim-coffee-script'")
cmd("Plug 'kthibodeaux/tig.vim'")
cmd("Plug 'lisinge/vim-slim'")
cmd("Plug 'neoclide/coc.nvim', {'branch': 'release'}")
cmd("Plug 'nvim-treesitter/nvim-treesitter'")
cmd("Plug 'pangloss/vim-javascript'")
cmd("Plug 'posva/vim-vue'")
cmd("Plug 'ryanoasis/vim-devicons'")
cmd("Plug 'scrooloose/nerdtree'")
cmd("Plug 'slm-lang/vim-slm'")
cmd("Plug 'thoughtbot/vim-rspec'")
cmd("Plug 'tpope/vim-commentary'")
cmd("Plug 'tpope/vim-endwise'")
cmd("Plug 'tpope/vim-rails'")
cmd("Plug 'tpope/vim-repeat'")
cmd("Plug 'tpope/vim-surround'")
cmd("Plug 'unblevable/quick-scope'")
cmd("Plug 'vim-ruby/vim-ruby'")
cmd("Plug 'voldikss/vim-floaterm'")
cmd("call plug#end()")

-------------
-- Settings --
-------------
cmd('au FileType * setlocal ai sw=2 sts=2 et')
cmd('let mapleader = " "')
cmd('filetype plugin indent on')
cmd('syntax on')

o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.backupdir = '~/.config/nvim/tmp'
o.clipboard = 'unnamedplus'
o.colorcolumn = '80'
o.directory = '~/.config/nvim/tmp'
o.encoding = 'UTF-8'
o.fileencoding = 'UTF-8'
o.gdefault = true
o.gdefault = true
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.laststatus = 2
o.ls = 2
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.ruler = true
o.scrolloff = 1
o.shortmess = 'I'
o.shortmess = 'atc'
o.showcmd = true
o.showmatch = true
o.signcolumn = 'yes'
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeout = true
o.timeoutlen = 1000
o.ttimeoutlen = 100
o.undodir = '~/.config/nvim/undodir'
o.undofile = true
o.undolevels = 1000
o.undoreload = 10000
o.updatetime = 300
o.visualbell = true
o.wildmenu = true


-------------
-- theme --
-------------
vim.g.tokyonight_transparent = 1
vim.g.tokyonight_italic_variables = 1
vim.g.tokyonight_italic_functions = 1
cmd('colorscheme tokyonight')

exec([[

"allow transparency of backgrounds
" highlight Visual term=reverse cterm=reverse guibg=Grey40
" highlight Normal guibg=NONE ctermbg=NONE
" highlight LineNr guibg=NONE ctermbg=NONE
" highlight SignColumn guibg=NONE ctermbg=NONE
" highlight EndOfBuffer guibg=NONE ctermbg=NONE
" highlight VertSplit guibg=NONE ctermbg=NONE
" highlight NonText guibg=none
" highlight NonText ctermbg=none
" highlight GitGutterAdd ctermbg=none
" highlight GitGutterChange ctermbg=none
" highlight GitGutterDelete ctermbg=none
" highlight GitGutterChangeDelete ctermbg=none

""quickscope
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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column  --no-heading --smart-case  --hidden --follow -g "!.git/*" --color "always" '.shellescape(<q-args>), 1,  fzf#vim#with_preview('right:60%')

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

let g:NERDTreeGitStatusIndicatorMapCustom = { "Modified"  : "✹", "Staged"    : "+", "Untracked" : "o", "Renamed"   : "➜", "Unmerged"  : "=", "Deleted"   : "x", "Dirty"     : "X", "Clean"     : "✔︎", "Unknown"   : "?" }
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

let g:coc_global_extensions = [ 'coc-css', 'coc-eslint', 'coc-html', 'coc-json', 'coc-snippets', 'coc-solargraph', 'coc-tsserver', 'coc-vetur', 'coc-yaml' ]

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=251, on_visual=true}
]], false)
