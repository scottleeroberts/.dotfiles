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
cmd("Plug 'jiangmiao/auto-pairs'")
cmd("Plug 'wellle/targets.vim'")
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
map('i', ',', ',<c-g>u',  options)
map('i', '.', '.<c-g>u',  options)
map('i', '!', '!<c-g>u',  options)
map('i', '?', '?<c-g>u',  options)

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
map('n', 'J', "mzJ'z", options)
map('n', '<leader>gg', ':tab new<CR>', options)
map('n', '<leader>gn', ':tabnew %<CR>', options)
map('n', '<leader><CR>', 'gt', options)
map('n', '<Leader>s', ':source $MYVIMRC<CR>', options)
map('n', '<leader>/', ':Files<CR>', options) -- Close the buffer and reuse the window for an existing buffer
map('n', '<leader><tab>', 'mtgg=G`t', options) -- format entire file

map('v', '<C-c>', '"+y', options)
map('n', '<C-c>', '"+yy', options)
map('i', '<C-c>', '<ESC>"+yyi', options)

exec([[
  nnoremap <expr> k (v:count > 5 ? "m'" . v:count: "") . 'k'
  nnoremap <expr> j (v:count > 5 ? "m'" . v:count: "") . 'j'
]], false)

map('v', 'J', ":m '>+1<CR>gv=gv", options)
map('v', 'K', ":m '<-1<CR>gv=gv", options)

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
map('n', '<leader>vc', '<Plug>TigFileHistory', {})
map('n', '<leader>vv', '<Plug>TigBlame', {})
map('n', '<leader>vb', '<Plug>TigLatestCommitForLine', {})
map('n', '<leader>vx', ':Commits<CR>', options)
map('n', '<leader>vz', ':GFiles?<CR>', options)

--navigation qwerty vs colemak
map('n', '<leader>lq', '<Plug>UseQwertyNavigation', options)
map('n', '<leader>lc', '<Plug>UseColemakNavigation', options)

--argwrap
map('n', '<leader>a', ':ArgWrap<CR>', silent_options)

----------------
-- Plugins --
----------------

-- Quickscope
cmd("highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline")
cmd("highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")

-- Statusline
vim.api.nvim_set_option('statusline', ''
  .. '%f '
  .. '%m '
  .. '%{coc#status()} '
  .. '%r '
  .. '%='
  .. '%y '
  .. '%l:%c'
)


-- NerdTree
g.NERDTreeStatusline='%{substitute(system("git branch --show-current"), "\n", " ", "g")}'
g.NERDTreeMinimalUI=1
g.NERDTreeShowHidden=1
g.NERDTreeShowHiddenFirst=1
g.NERDTreeDirArrowExpandable =  ''
g.NERDTreeDirArrowCollapsible = ''
g.WebDevIconsNerdTreeBeforeGlyphPadding = ""
g.WebDevIconsUnicodeDecorateFolderNodes = true
g.NERDTreeGitStatusIndicatorMapCustom = {
  Modified='✹',
  Staged='+',
  Untracked='o',
  Renamed='➜',
  Unmerged='=',
  Deleted='x',
  Dirty='X',
  Clean='✔︎',
  Unknown='?'
}
exec([[
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  highlight! link NERDTreeFlags NERDTreeDir
]], false)

-- Floatterm
vim.api.nvim_exec([[
  command! FZF FloatermNew fzf
]], false)


-- fzf
vim.api.nvim_exec([[
  command! -bang -nargs=* Find call fzf#vim#grep( 'rg --column  --no-heading --smart-case  --hidden --follow -g "!.git/*" --color "always" '.shellescape(<q-args>), 0, fzf#vim#with_preview('up:70%'))
]], false)

-- Highlight current column in active pane only
vim.api.nvim_exec([[
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END
]], false)

-- ruby
g.ruby_indent_block_style = 'do' -- https://github.com/vim-ruby/vim-ruby/blob/master/doc/vim-ruby.txt#L133

-- auto-pairs configuration
g.AutoPairsMultilineClose=0

--argwrap
g.argwrap_padded_braces = '{'
g.argwrap_tail_comma = 1

-- config code commentting
cmd("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
cmd("autocmd FileType vue setlocal commentstring=//\\ %s")

-- Vue `gf` for components
o.suffixesadd = '.vue'
o.path = '.,app/javascript/**'
g.vue_pre_processors = 'detect_on_enter'

--closetag
g.closetag_filetypes = 'html,vue,xhtml'
g.closetag_xhtml_filetypes = 'html,vue,xhtml'

--coc
g.coc_snippet_prev = '<c-p>'
g.coc_snippet_next = '<c-n>'
g.coc_global_extensions = { 'coc-css', 'coc-eslint', 'coc-html', 'coc-json', 'coc-snippets', 'coc-solargraph', 'coc-tsserver', 'coc-vetur', 'coc-yaml' }

--iabbr
vim.cmd('iabbr pry ::Kernel.binding.pry')

-- Open to last position in file
exec([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif  ]], false)

--highlight on yank
exec([[
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=251, on_visual=true}
]], false)
