local keymap = vim.keymap.set

-- ============================================================================
-- Leader Key
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Insert Mode
-- ============================================================================
keymap("i", "jj", "<Esc>", { noremap = true, desc = "Exit insert mode" })
keymap("i", ",", ",<c-g>u", { noremap = true, desc = "Undo breakpoint ," })
keymap("i", ".", ".<c-g>u", { noremap = true, desc = "Undo breakpoint ." })
keymap("i", "!", "!<c-g>u", { noremap = true, desc = "Undo breakpoint !" })
keymap("i", "?", "?<c-g>u", { noremap = true, desc = "Undo breakpoint ?" })

-- ============================================================================
-- Normal Mode - General
-- ============================================================================
keymap("n", "<CR>", ":noh<CR><CR>", { noremap = true, desc = "Clear search highlight" })
keymap("n", "Y", "y$", { noremap = true, desc = "Yank to end of line" })
keymap("n", "n", "nzz", { noremap = true, desc = "Next search result (centered)" })
keymap("n", "N", "Nzz", { noremap = true, desc = "Prev search result (centered)" })
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Half page down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Half page up (centered)" })

-- Normal Mode - Editing
keymap("n", "S", "i<cr><esc>^mwgk:silent! s/\\v +$//<cr>:noh<cr>$", { noremap = true, desc = "Split line" })
keymap("n", "K", "mzJx'z", { noremap = true, desc = "Join lines" })

-- Normal Mode - File Operations
keymap("n", "<leader>w", ":update<CR>", { noremap = true, desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { noremap = true, desc = "Quit" })
keymap("n", "<leader>d", ":bd<CR>", { noremap = true, desc = "Delete buffer" })

-- Normal Mode - Splits
keymap("n", "<leader>o", ":vs<CR>", { noremap = true, desc = "Vertical split" })
keymap("n", "<leader>i", ":sp<CR>", { noremap = true, desc = "Horizontal split" })

-- Normal Mode - Tabs
keymap("n", "<leader>gg", ":tab new<CR>", { noremap = true, desc = "New tab" })
keymap("n", "<leader>gn", ":tabnew %<CR>", { noremap = true, desc = "New tab (current file)" })
keymap("n", "<leader><CR>", "gt", { noremap = true, desc = "Next tab" })

-- ============================================================================
-- Visual Mode
-- ============================================================================
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selection up" })

-- ============================================================================
-- Terminal Mode
-- ============================================================================
keymap("t", "jj", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- ============================================================================
-- Window Resizing
-- ============================================================================
keymap("n", "<Up>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Resize window up" })
keymap("n", "<Down>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Resize window down" })
keymap("n", "<Left>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Resize window wider" })
keymap("n", "<Right>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Resize window narrower" })
