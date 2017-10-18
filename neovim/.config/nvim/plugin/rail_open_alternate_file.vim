function! RailsOpenAltCommand(path, vim_command)
  if a:path =~ "spec/"
    let l:alternate = substitute(a:path, "spec/", "app/", "")
    let l:alternate = substitute(l:alternate, "_spec", "", "")
  elseif a:path =~ "app/"
    let l:alternate = substitute(a:path, "app/", "spec/", "")
    let l:alternate = substitute(l:alternate, ".rb", "_spec.rb", "")
  endif

  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction
