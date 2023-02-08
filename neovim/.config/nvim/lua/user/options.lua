local options = {
  backspace = 'indent,eol,start',
  backupcopy = 'yes',
  backupdir = config .. '/tmp//',
  clipboard = 'unnamedplus',
  colorcolumn = '80',
  directory = config .. '/tmp//',
  encoding = 'UTF-8',
  expandtab = true,
  fileencoding = 'UTF-8',
  gdefault = true,
  hidden = true,
  hlsearch = true,
  ignorecase = true,
  incsearch = true,
  laststatus = 2,
  ls = 2,
  mouse = 'a',
  number = true,
  path = '.,app/javascript/**',
  relativenumber = true,
  ruler = true,
  scrolloff = 8,
  shiftwidth = 2,
  showcmd = true,
  showmatch = true,
  signcolumn = 'yes',
  smartcase = true,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  suffixesadd = '.vue',
  tabstop = 2,
  termguicolors = true,
  timeout = true,
  timeoutlen = 1000,
  ttimeoutlen = 100,
  undodir = config .. '/undodir//',
  undofile = true,
  undolevels = 1000,
  undoreload = 10000,
  updatetime = 300,
  visualbell = true,
  wildmenu = true,
  wrap = false,
}

for k,v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd('syntax enable')
vim.cmd('filetype indent plugin on')
