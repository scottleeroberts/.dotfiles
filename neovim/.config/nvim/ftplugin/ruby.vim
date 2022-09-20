setlocal iskeyword+=!
setlocal iskeyword+=?
setlocal iskeyword+=:
setlocal iskeyword+=.

" RSpec.vim mappings
let g:rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rr :call RunNearestSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

"Rails file navigation
nnoremap <leader>c :Econtroller<CR>
nnoremap <leader>m :Emodel<CR>
nnoremap <leader>v :Eview<CR>
nnoremap <leader>u :Eunittest<CR>

autocmd BufWritePre <buffer> silent call CocAction('format')

