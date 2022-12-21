setlocal iskeyword+=!
setlocal iskeyword+=?
setlocal iskeyword+=-
autocmd BufNewFile,BufRead *.slim setlocal filetype=ruby
