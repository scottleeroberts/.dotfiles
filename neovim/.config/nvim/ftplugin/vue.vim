setlocal isfname-=.
setlocal iskeyword+=-

if filereadable(expand('.eslintrc'))
  autocmd BufWritePre <buffer> EslintFixAll
endif
