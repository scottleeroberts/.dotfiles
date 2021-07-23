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

local home = vim.env.HOME
local config = home .. '/.config/nvim'

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
-- Setup --
-------------
cmd('au FileType * setlocal ai sw=2 sts=2 et')
cmd('let mapleader = " "')
cmd('filetype plugin indent on')
cmd('syntax on')

-------------
-- Settings --
-------------
o.backspace = 'indent,eol,start'
o.backupcopy = 'yes'
o.backupdir = config .. '/tmp//'
o.directory = config .. '/tmp//'
o.clipboard = 'unnamedplus'
o.colorcolumn = '80'
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
o.undodir = config .. '/undodir//'
o.undofile = true
o.undolevels = 1000
o.undoreload = 10000
o.updatetime = 300
o.visualbell = true
o.wildmenu = true
o.wrap = false
-------------
-- theme --
-------------
vim.g.tokyonight_transparent = 1
vim.g.tokyonight_italic_variables = 1
vim.g.tokyonight_italic_functions = 1
cmd('colorscheme tokyonight')

-------------
-- Mappings --
-------------
local options = { noremap = true }
local silent_options = { noremap = true, silent = true }

map('i', 'jj', '<Esc>', options)
map('n', '<CR>', ':noh<CR><CR>', options)
map('n', 'S', 'i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$', options) -- split line
map('n', '<leader>d', ':bd<CR>', options)
map('n', '<leader>q', ':q<CR>', options)
map('n', '<leader>w', ':update<CR>', options)
map('n', '<leader>g', '<C-]>', options)
map('n', '<leader>b', ':Buffer<CR>', options)
map('n', '<leader>.', ":call RailsOpenAltCommand(expand('%'), ':vsplit')<cr>", options)
map('n', '<leader>ff', ':Find<space>', options)
map('n', '<leader>fs', ':Find<space><c-R><c-W><CR>', options)
map('n', '<leader>fv', ':vs<CR>:Find<space>', options)
map('n', '<leader>mi', ':edit db/migrate<CR>G', options)
map('n', '<leader>o', ':vs<CR>', options)
map('n', '<leader>i', ':sp<CR>', options)
map('n', '<leader>z', 'zR', options)
map('n', 'n', 'nzz', options)
map('n', 'N', 'Nzz', options)
map('n', '<leader>f', ':tab new<CR>', options)
map('n', '<leader><CR>', 'gt', options)
map('n', '<Leader>s', ':source $MYVIMRC<CR>', options)
map('n', '<leader>/', ':Files<CR>', options) -- Close the buffer and reuse the window for an existing buffer
map('n', '<leader><tab>', 'mtgg=G`t', options) -- format entire file

--tmux
map('n', '<c-h>', ':TmuxNavigateLeft<cr>', silent_options)
map('n', '<c-j>', ':TmuxNavigateDown<cr>', silent_options)
map('n', '<c-k>', ':TmuxNavigateUp<cr>', silent_options)
map('n', '<c-l>', ':TmuxNavigateRight<cr>', silent_options)

--floaterm
map('n', '<leader>tt', ':FloatermToggle<CR>', options)
map('t', '<leader>tt', "<c-\\><C-n>:FloatermToggle<CR>", options)

--vim-surround
map('n', 'sw', 'ysiw', options)
map('n', 'Y', 'y$', options)

-- Resizing splits
map('n', '<Up>', ':resize -2<CR>', silent_options)
map('n', '<Down>', ':resize +2<CR>', silent_options)
map('n', '<Left>', ':vertical resize +2<CR>', silent_options)
map('n', '<Right>', ':vertical resize -2<CR>', silent_options)

--nerdtree
map('n', '<C-n>', ':NERDTreeFind<CR>', options)

--tig and git mappings
map('n', '<leader>vc', '<Plug>TigFileHistory', options)
map('n', '<leader>vv', '<Plug>TigBlame', options)
map('n', '<leader>vb', '<Plug>TigLatestCommitForLine', options)
map('n', '<leader>vx', ':Commits<CR>', options)
map('n', '<leader>vz', ':GFiles?<CR>', options)

--navigation qwerty vs colemak
map('n', '<leader>lq', '<Plug>UseQwertyNavigation', options)
map('n', '<leader>lc', '<Plug>UseColemakNavigation', options)

--argwrap
map('n', '<leader>a', ':ArgWrap<CR>', silent_options)

-------------
-- Quickscope --
-------------
cmd("highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline")
cmd("highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")

exec([[

" status line configuration
set statusline=
set statusline+=\ %F
set statusline+=\ %m
set statusline+=\ %{coc#status()}
set statusline+=%r
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %l:%c

let g:floaterm_position = 'center'

set rtp+=~/.fzf

command! FZF FloatermNew fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column  --no-heading --smart-case  --hidden --follow -g "!.git/*" --color "always" '.shellescape(<q-args>), 1,  fzf#vim#with_preview('right:60%'))
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

"New line in commented section is not commented
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType vue setlocal commentstring=//\ %s

" Vue `gf` for components
set suffixesadd=.vue
set path=.,app/javascript/**

let g:closetag_filetypes = 'html,vue,xhtml'
let g:closetag_xhtml_filetypes = 'html,vue,xhtml'

let g:vue_pre_processors = 'detect_on_enter'

let g:coc_snippet_prev = '<c-p>'
let g:coc_snippet_next = '<c-n>'

let g:coc_global_extensions = [ 'coc-css', 'coc-eslint', 'coc-html', 'coc-json', 'coc-snippets', 'coc-solargraph', 'coc-tsserver', 'coc-vetur', 'coc-yaml' ]

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=251, on_visual=true}
]], false)
