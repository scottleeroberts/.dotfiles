local keymap = vim.api.nvim_set_keymap

local options = { noremap = true }
local silent_options = { noremap = true, silent = true }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", silent_options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps
keymap('i', 'jj', '<Esc>', options)
keymap('i', ',', ',<c-g>u',  options)
keymap('i', '.', '.<c-g>u',  options)
keymap('i', '!', '!<c-g>u',  options)
keymap('i', '?', '?<c-g>u',  options)

keymap('n', '-', '<CMD>Oil<CR>', options)

keymap('n', '<CR>', ':noh<CR><CR>', options)
keymap('n', 'S', 'i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$', options) -- split line
keymap('n', '<leader>d', ':bd<CR>', options)
keymap('n', '<leader>q', ':q<CR>', options)
keymap('n', '<leader>w', ':update<CR>', options)
keymap('n', '<leader>o', ':vs<CR>', options)
keymap('n', '<leader>i', ':sp<CR>', options)
keymap('n', '<leader>z', 'zR', options)
keymap('n', 'n', 'nzz', options)
keymap('n', 'N', 'Nzz', options)
keymap('n', 'K', "mzJx'z", options)
keymap('n', '<leader>gg', ':tab new<CR>', options)
keymap('n', '<leader>gn', ':tabnew %<CR>', options)
keymap('n', '<leader><CR>', 'gt', options)
keymap('n', '<C-d>', '<C-d>zz', options)
keymap('n', '<C-u>', '<C-u>zz', options)

keymap('t', 'jj', '<C-\\><C-n>', options)

keymap('n', 'Y', 'y$', options)

keymap('v', 'J', ":m '>+1<CR>gv=gv", options)
keymap('v', 'K', ":m '<-2<CR>gv=gv", options)

keymap('n', 'gf', '<cmd> lua vim.lsp.buf.definition()<CR>', options)

--tmux
keymap('n', '<c-h>', ':TmuxNavigateLeft<cr>', silent_options)
keymap('n', '<c-j>', ':TmuxNavigateDown<cr>', silent_options)
keymap('n', '<c-k>', ':TmuxNavigateUp<cr>', silent_options)
keymap('n', '<c-l>', ':TmuxNavigateRight<cr>', silent_options)

--floaterm
keymap('n', '<leader>tt', ':FloatermToggle<CR>', options)
keymap('t', '<leader>tt', "<c-\\><C-n>:FloatermToggle<CR>", options)

-- Resizing splits
keymap('n', '<Up>', ':resize -2<CR>', silent_options)
keymap('n', '<Down>', ':resize +2<CR>', silent_options)
keymap('n', '<Left>', ':vertical resize +2<CR>', silent_options)
keymap('n', '<Right>', ':vertical resize -2<CR>', silent_options)

--file and git mappings
keymap('n', '<leader>/', "<cmd>lua require'telescope.builtin'.find_files({find_command = {'rg', '--files', '--hidden', '-g', '!.git' }}) preview={timeout=1000}<cr>", options)
keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').grep_string({use_regex=true, search = vim.fn.input('Grep For > '), vimgrep_arguments = {'rg', '--vimgrep', '--hidden', '--glob', '!.git/**'}})<CR>", options)
keymap('n', '<leader>fs', "<cmd>lua require('telescope.builtin').grep_string({vimgrep_arguments = {'rg', '--vimgrep', '--hidden', '--glob', '!.git/**'}})<CR>", options)

keymap('n', '<leader>gc', '<cmd>Gitsigns blame_line<CR>', options)
keymap('n', '<leader>gb', "<cmd>lua bcommits()<CR>", {})
keymap('n', '<leader>gs', '<cmd>Telescope git_stash<CR>', options)
keymap('n', '<leader>gt', '<cmd>Telescope git_status<CR>', options)
keymap('n', '<leader>gv', '<Plug>TigBlame', {})
keymap('n', '<leader>gq', "<cmd>lua require'telescope.builtin'.quickfix()<cr>", options)
keymap('n', '<leader>gr', '<cmd>Telescope git_branches<CR>', options)
keymap('n', '<leader>mi', "<cmd>lua require'telescope.builtin'.find_files({sorting_strategy='descending', cwd='db/migrate', find_command = {'rg', '--files', '--hidden', '-g', '!.git', '--sortr=path' }})<cr>", options)

keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', options)
keymap('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<CR>',options)
keymap('n', '<leader>rt', '<cmd>lua vim.fn.VimuxRunCommand("bin/eng_system_tests " .. vim.fn.expand("%:p") .. "; notify")<CR>', options)
keymap('n', '<leader>rd', '<cmd>lua vim.fn.VimuxRunCommand("bin/debug_eng_system_tests " .. vim.fn.expand("%:p") .. "; notify")<CR>', options)

--navigation qwerty vs colemak
keymap('n', '<leader>lq', '<Plug>UseQwertyNavigation', options)
keymap('n', '<leader>lc', '<Plug>UseColemakNavigation', options)

--argwrap
keymap('n', '<leader>a', ':ArgWrap<CR>', silent_options)

-- Nvimtree
keymap("n", "<c-n>", ":NvimTreeFocus<cr>", options)

keymap("i", "<C-l>", "copilot#Accept('<CR>')", {noremap = true, silent = true, expr=true, replace_keycodes = false })
keymap("n", "<leader>cc", "<cmd>CopilotChat<cr>", options)
keymap("v", "<leader>cc", ":'<,'>CopilotChat<cr>", options)

