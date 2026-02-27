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
-- Window Resizing
-- ============================================================================
keymap("n", "<Up>", ":resize -2<CR>", silent_options)
keymap("n", "<Down>", ":resize +2<CR>", silent_options)
keymap("n", "<Left>", ":vertical resize +2<CR>", silent_options)
keymap("n", "<Right>", ":vertical resize -2<CR>", silent_options)
