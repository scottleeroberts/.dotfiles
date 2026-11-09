local options = {
  backupcopy = 'yes',
  backupdir = config .. '/tmp//',
  clipboard = 'unnamedplus',
  colorcolumn = '120',
  directory = config .. '/tmp//',
  expandtab = true,
  fileencoding = 'UTF-8',
  gdefault = true,
  ignorecase = true,
  mouse = 'a',
  number = true,
  path = '.,app/javascript/**',
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2,
  showmatch = true,
  signcolumn = 'yes',
  smartcase = true,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  suffixesadd = '.vue',
  tabstop = 2,
  termguicolors = true,
  ttimeoutlen = 100,
  undodir = config .. '/undodir//',
  undofile = true,
  updatetime = 300,
  visualbell = true,
  wrap = false,
  winborder = 'single'
}

for k,v in pairs(options) do
  vim.opt[k] = v
end
