vim.cmd("call plug#begin('~/.config/nvim/plugged')")

local plugins = {
  "Plug 'FooSoft/vim-argwrap'",
  "Plug 'Xuyuanp/nerdtree-git-plugin'",
  "Plug 'airblade/vim-gitgutter'",
  "Plug 'alvan/vim-closetag'",
  "Plug 'ap/vim-css-color'",
  "Plug 'benmills/vimux'",
  "Plug 'chrisbra/Recover.vim'",
  "Plug 'christoomey/vim-tmux-navigator'",
  "Plug 'digitaltoad/vim-pug'",
  "Plug 'EdenEast/nightfox.nvim'",
  "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }",
  "Plug 'junegunn/fzf.vim'",
  "Plug 'kchmck/vim-coffee-script'",
  "Plug 'kthibodeaux/tig.vim'",
  "Plug 'lisinge/vim-slim'",
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}",
  "Plug 'nvim-treesitter/nvim-treesitter'",
  "Plug 'pangloss/vim-javascript'",
  "Plug 'posva/vim-vue'",
  "Plug 'ryanoasis/vim-devicons'",
  "Plug 'scrooloose/nerdtree'",
  "Plug 'slm-lang/vim-slm'",
  "Plug 'thoughtbot/vim-rspec'",
  "Plug 'tpope/vim-abolish'",
  "Plug 'tyru/caw.vim'",
  "Plug 'tpope/vim-endwise'",
  "Plug 'tpope/vim-rails'",
  "Plug 'tpope/vim-repeat'",
  "Plug 'tpope/vim-surround'",
  "Plug 'unblevable/quick-scope'",
  "Plug 'vim-ruby/vim-ruby'",
  "Plug 'voldikss/vim-floaterm'",
  "Plug 'jiangmiao/auto-pairs'",
  "Plug 'wellle/targets.vim'",
  "Plug 'kyazdani42/nvim-web-devicons'",
  "Plug 'nvim-lua/plenary.nvim'",
  "Plug 'nvim-lua/popup.nvim'",
  "Plug 'nvim-telescope/telescope.nvim'",
  "Plug 'nvim-telescope/telescope-fzy-native.nvim'",
}

for p, plugin in ipairs(plugins) do
  vim.cmd(plugin)
end

vim.cmd("call plug#end()")
