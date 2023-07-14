local keymap = vim.api.nvim_set_keymap

local options = { noremap = true }
local silent_options = { noremap = true, silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", silent_options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "local map = vim.api.nvim_set_keymap

-- Keymaps
keymap('i', 'jj', '<Esc>', options)
keymap('i', ',', ',<c-g>u',  options)
keymap('i', '.', '.<c-g>u',  options)
keymap('i', '!', '!<c-g>u',  options)
keymap('i', '?', '?<c-g>u',  options)

keymap('n', '<CR>', ':noh<CR><CR>', options)
keymap('n', 'S', 'i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$', options) -- split line
keymap('n', '<leader>d', ':bd<CR>', options)
keymap('n', '<leader>q', ':q<CR>', options)
keymap('n', '<leader>w', ':update<CR>', options)
keymap('n', '<leader>g', '<C-]>', options)
keymap('n', '<leader>.', ":call RailsOpenAltCommand(expand('%'), ':vsplit')<cr>", options)
keymap('n', '<leader>o', ':vs<CR>', options)
keymap('n', '<leader>i', ':sp<CR>', options)
keymap('n', '<leader>z', 'zR', options)
keymap('n', 'n', 'nzz', options)
keymap('n', 'N', 'Nzz', options)
keymap('n', 'K', "mzJx'z", options)
keymap('n', '<leader>gg', ':tab new<CR>', options)
keymap('n', '<leader>gn', ':tabnew %<CR>', options)
keymap('n', '<leader><CR>', 'gt', options)
keymap('n', '<Leader>s', ':source $MYVIMRC<CR>', options)
keymap('n', '<leader><tab>', 'mtgg=G`t', options) -- format entire file
keymap('n', '<C-d>', '<C-d>zz', options)
keymap('n', '<C-u>', '<C-u>zz', options)

keymap('t', 'jj', '<C-\\><C-n>', options)

keymap('n', 'Y', 'y$', options)

keymap('v', 'J', ":m '>+1<CR>gv=gv", options)
keymap('v', 'K', ":m '<-2<CR>gv=gv", options)

keymap('n', '<leader>p', ':call GoToNextIndent(1)<CR>', options)
keymap('n', '<leader>P', ':call GoToNextIndent(-1)<CR>', options)

--tmux
keymap('n', '<c-h>', ':TmuxNavigateLeft<cr>', silent_options)
keymap('n', '<c-j>', ':TmuxNavigateDown<cr>', silent_options)
keymap('n', '<c-k>', ':TmuxNavigateUp<cr>', silent_options)
keymap('n', '<c-l>', ':TmuxNavigateRight<cr>', silent_options)

--floaterm
keymap('n', '<leader>tt', ':FloatermToggle<CR>', options)
keymap('t', '<leader>tt', "<c-\\><C-n>:FloatermToggle<CR>", options)

--vim-surround
keymap('n', 'ys', 'ysiw', options)

-- Resizing splits
keymap('n', '<Up>', ':resize -2<CR>', silent_options)
keymap('n', '<Down>', ':resize +2<CR>', silent_options)
keymap('n', '<Left>', ':vertical resize +2<CR>', silent_options)
keymap('n', '<Right>', ':vertical resize -2<CR>', silent_options)

--file and git mappings
keymap('n', '<leader>/', "<cmd>lua require'telescope.builtin'.find_files({find_command = {'rg', '--files', '--hidden', '-g', '!.git' }}) preview={timeout=1000}<cr>", options)
keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.input('Grep For > ')})<CR>", options)
keymap('n', '<leader>fs', '<cmd>Telescope grep_string<CR>', options)

keymap('n', '<leader>vc', '<cmd>Telescope git_commits<CR>', {})
keymap('n', '<leader>vb', '<cmd>Telescope git_bcommits<CR>', {})
keymap('n', '<leader>vs', '<cmd>Telescope git_stash<CR>', options)
keymap('n', '<leader>vv', '<Plug>TigBlame', {})
keymap('n', '<leader>mi', "<cmd>lua require'telescope.builtin'.find_files({sorting_strategy='descending', cwd='db/migrate', find_command = {'rg', '--files', '--hidden', '-g', '!.git', '--sortr=path' }})<cr>", options)

keymap('n', '<leader>gs', '<cmd>Telescope git_status<CR>', options)
keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', options)
keymap('n', '<leader>gr', '<cmd>Telescope git_branches<CR>', options)


--navigation qwerty vs colemak
keymap('n', '<leader>lq', '<Plug>UseQwertyNavigation', options)
keymap('n', '<leader>lc', '<Plug>UseColemakNavigation', options)

--argwrap
keymap('n', '<leader>a', ':ArgWrap<CR>', silent_options)

-- Nvimtree
keymap("n", "<c-n>", ":NvimTreeFocus<cr>", options)

