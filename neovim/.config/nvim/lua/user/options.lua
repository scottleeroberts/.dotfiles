local options = {
  backspace = 'indent,eol,start',
  backupcopy = 'yes',
  backupdir = config .. '/tmp//',
  clipboard = 'unnamedplus',
  colorcolumn = '80',
  directory = config .. '/tmp//',
  encoding = 'UTF-8',
  fileencoding = 'UTF-8',
  gdefault = true,
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
  scrolloff = 1,
  showcmd = true,
  showmatch = true,
  signcolumn = 'yes',
  smartcase = true,
  splitbelow = true,
  splitright = true,
  suffixesadd = '.vue',
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
