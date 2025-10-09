local keymap = vim.keymap.set

local options = { noremap = true }
local silent_options = { noremap = true, silent = true }

-- ============================================================================
-- Leader Key
-- ============================================================================
keymap("", "<Space>", "<Nop>", silent_options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Insert Mode
-- ============================================================================
keymap("i", "jj", "<Esc>", options)
keymap("i", ",", ",<c-g>u", options)
keymap("i", ".", ".<c-g>u", options)
keymap("i", "!", "!<c-g>u", options)
keymap("i", "?", "?<c-g>u", options)

-- ============================================================================
-- Normal Mode - General
-- ============================================================================
keymap("n", "<CR>", ":noh<CR><CR>", options)
keymap("n", "Y", "y$", options)
keymap("n", "n", "nzz", options)
keymap("n", "N", "Nzz", options)
keymap("n", "<C-d>", "<C-d>zz", options)
keymap("n", "<C-u>", "<C-u>zz", options)

-- Normal Mode - Editing
keymap("n", "S", "i<cr><esc>^mwgk:silent! s/\\v +$//<cr>:noh<cr>$", options) -- split line
keymap("n", "K", "mzJx'z", options) -- join lines
keymap("n", "gf", "<cmd>lua vim.lsp.buf.definition()<CR>", options)

-- Normal Mode - File Operations
keymap("n", "<leader>w", ":update<CR>", options)
keymap("n", "<leader>q", ":q<CR>", options)
keymap("n", "<leader>d", ":bd<CR>", options)

-- Normal Mode - Splits
keymap("n", "<leader>o", ":vs<CR>", options)
keymap("n", "<leader>i", ":sp<CR>", options)

-- Normal Mode - Tabs
keymap("n", "<leader>gg", ":tab new<CR>", options)
keymap("n", "<leader>gn", ":tabnew %<CR>", options)
keymap("n", "<leader><CR>", "gt", options)

-- Normal Mode - Folding
keymap("n", "<leader>z", "zR", options)

-- ============================================================================
-- Visual Mode
-- ============================================================================
keymap("v", "J", ":m '>+1<CR>gv=gv", options)
keymap("v", "K", ":m '<-2<CR>gv=gv", options)

-- ============================================================================
-- Terminal Mode
-- ============================================================================
keymap("t", "jj", "<C-\\><C-n>", options)

-- ============================================================================
-- Plugin: Tmux Navigator
-- ============================================================================
keymap("n", "<c-h>", ":TmuxNavigateLeft<cr>", silent_options)
keymap("n", "<c-j>", ":TmuxNavigateDown<cr>", silent_options)
keymap("n", "<c-k>", ":TmuxNavigateUp<cr>", silent_options)
keymap("n", "<c-l>", ":TmuxNavigateRight<cr>", silent_options)
keymap("t", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", silent_options)
keymap("t", "<c-j>", "<cmd>TmuxNavigateDown<cr>", silent_options)
keymap("t", "<c-k>", "<cmd>TmuxNavigateUp<cr>", silent_options)
keymap("t", "<c-l>", "<cmd>TmuxNavigateRight<cr>", silent_options)

-- ============================================================================
-- Plugin: Floaterm
-- ============================================================================
keymap("n", "<leader>tt", ":FloatermToggle<CR>", options)
keymap("t", "<leader>tt", "<c-\\><C-n>:FloatermToggle<CR>", options)

-- ============================================================================
-- Plugin: Window Resizing
-- ============================================================================
keymap("n", "<Up>", ":resize -2<CR>", silent_options)
keymap("n", "<Down>", ":resize +2<CR>", silent_options)
keymap("n", "<Left>", ":vertical resize +2<CR>", silent_options)
keymap("n", "<Right>", ":vertical resize -2<CR>", silent_options)

-- ============================================================================
-- Plugin: Oil
-- ============================================================================
keymap("n", "-", "<CMD>Oil<CR>", options)

-- ============================================================================
-- Plugin: Telescope - File Finding
-- ============================================================================
keymap("n", "<leader>/", "<cmd>lua require'telescope.builtin'.find_files({find_command = {'rg', '--files', '--hidden', '-g', '!.git' }, preview={timeout=1000}})<cr>", options)
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').grep_string({use_regex=true, search = vim.fn.input('Grep For > '), vimgrep_arguments = {'rg', '--vimgrep', '--smart-case', '--hidden', '--glob', '!.git/**'}})<CR>", options)
keymap("n", "<leader>fs", "<cmd>lua require('telescope.builtin').grep_string({vimgrep_arguments = {'rg', '--vimgrep', '--hidden', '--glob', '!.git/**'}})<CR>", options)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", options)
keymap("n", "<leader>bb", "<cmd>Telescope buffers<CR>", options)
keymap("n", "<leader>mi", "<cmd>lua require'telescope.builtin'.find_files({sorting_strategy='descending', cwd='db/migrate', find_command = {'rg', '--files', '--hidden', '-g', '!.git', '--sortr=path' }})<cr>", options)

-- ============================================================================
-- Plugin: Telescope/Gitsigns - Git Operations
-- ============================================================================
keymap("n", "<leader>gc", "<cmd>Gitsigns blame_line<CR>", options)
keymap("n", "<leader>gb", "<cmd>Telescope git_bcommits<CR>", options)
keymap("n", "<leader>gs", "<cmd>Telescope git_stash<CR>", options)
keymap("n", "<leader>gt", "<cmd>Telescope git_status<CR>", options)
keymap("n", "<leader>gv", "<cmd>Gitsigns blame<CR>", options)
keymap("n", "<leader>gq", "<cmd>lua require'telescope.builtin'.quickfix()<cr>", options)
keymap("n", "<leader>gr", "<cmd>Telescope git_branches<CR>", options)

-- ============================================================================
-- Plugin: LSP Diagnostics
-- ============================================================================
keymap("n", "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<CR>", options)

-- ============================================================================
-- Plugin: ArgWrap
-- ============================================================================
keymap("n", "<leader>a", ":ArgWrap<CR>", silent_options)

-- ============================================================================
-- Plugin: NvimTree
-- ============================================================================
keymap("n", "<c-n>", ":NvimTreeFocus<cr>", options)
