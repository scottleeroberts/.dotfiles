setlocal iskeyword+=!
setlocal iskeyword+=?

nmap <buffer> <leader><tab> :call CocAction('format')<CR>
