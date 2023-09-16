local lsp = require("lsp-zero").preset({})
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup()

vim.diagnostic.config({
    virtual_text = false
})
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float({scope="line"})]])
