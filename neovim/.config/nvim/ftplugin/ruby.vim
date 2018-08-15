setlocal iskeyword+=!
setlocal iskeyword+=?

" iskeyword is local, so we remove it before leaving the buffer
au BufLeave <buffer> set iskeyword-=:
nnoremap <silent> <buffer> <leader>g :set iskeyword+=:<CR><C-]>
