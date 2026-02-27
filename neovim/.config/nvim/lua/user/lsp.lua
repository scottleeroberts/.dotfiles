vim.env.PATH = vim.fn.stdpath('data') .. '/mason/bin:' .. vim.env.PATH

local lsp_dir = vim.fn.stdpath('config') .. '/lsp/'
local servers = { 'golangci_lint_ls', 'gopls', 'lua_ls', 'rubocop', 'ruby_lsp', 'ts_ls' }
for _, server in ipairs(servers) do
  vim.lsp.config(server, dofile(lsp_dir .. server .. '.lua'))
end
vim.lsp.enable(servers)

vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = 'Go to Definition' })
vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { desc = 'Go to Implementation' })
vim.keymap.set('n', '<leader>lr', '<cmd>Telescope lsp_references<cr>', { desc = 'References' })
vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' })
vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'LSP Diagnostics' })
vim.keymap.set('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>lw', '<cmd>Telescope lsp_workspace_symbols<cr>', { desc = 'Workspace Symbols' })
vim.api.nvim_set_keymap('n', '<leader>ln', '<CMD> lua vim.lsp.buf.rename()<CR>', { noremap = true, desc = 'rename' })
