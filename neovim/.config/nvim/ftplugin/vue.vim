setlocal isfname-=.
setlocal iskeyword+=-

autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
