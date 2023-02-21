setlocal isfname-=.
setlocal iskeyword+=-

autocmd BufWritePre <buffer> EslintFixAll
