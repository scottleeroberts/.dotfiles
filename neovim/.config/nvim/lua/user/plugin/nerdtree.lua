local g = vim.g

g.NERDTreeStatusline='%{substitute(system("git branch --show-current"), "\n", " ", "g")}'
g.NERDTreeMinimalUI=1
g.NERDTreeShowHidden=1
g.NERDTreeShowHiddenFirst=1
g.NERDTreeDirArrowExpandable =  ''
g.NERDTreeDirArrowCollapsible = ''
g.WebDevIconsNerdTreeBeforeGlyphPadding = ""
g.WebDevIconsUnicodeDecorateFolderNodes = true
g.NERDTreeGitStatusIndicatorMapCustom = {
  Modified='✹',
  Staged='+',
  Untracked='o',
  Renamed='➜',
  Unmerged='=',
  Deleted='x',
  Dirty='X',
  Clean='✔︎',
  Unknown='?'
}

vim.api.nvim_exec([[
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  highlight! link NERDTreeFlags NERDTreeDir
]], false)
