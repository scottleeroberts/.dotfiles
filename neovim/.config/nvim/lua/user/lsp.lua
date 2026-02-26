vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

vim.lsp.enable('golangci_lint_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('rubocop')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('ts_ls')

vim.keymap.set('n', 'gf', '<cmd>Telescope lsp_definitions<cr>', { desc = 'Go to Definition' })
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = 'Go to Definition' })
vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { desc = 'Go to Implementation' })
vim.keymap.set('n', '<leader>lr', '<cmd>Telescope lsp_references<cr>', { desc = 'References' })
vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' })
vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'LSP Diagnostics' })
vim.keymap.set('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>lw', '<cmd>Telescope lsp_workspace_symbols<cr>', { desc = 'Workspace Symbols' })
vim.api.nvim_set_keymap('n', '<leader>ln', '<CMD> lua vim.lsp.buf.rename()<CR>', { noremap = true, desc = 'rename' })
