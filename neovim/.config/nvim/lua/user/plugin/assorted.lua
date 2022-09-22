local exec = vim.api.nvim_exec
local cmd = vim.cmd
local g = vim.g
local o = vim.opt

-- Quickscope
cmd("highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline")
cmd("highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")

-- Statusline
vim.api.nvim_set_option('statusline', ''
  .. '%f '
  .. '%m '
  .. '%{coc#status()} '
  .. '%r '
  .. '%='
  .. '%y '
  .. '%l:%c'
)

-- ruby
g.ruby_indent_block_style = 'do' -- https://github.com/vim-ruby/vim-ruby/blob/master/doc/vim-ruby.txt#L133

-- auto-pairs configuration
g.AutoPairsMultilineClose=0

--argwrap
g.argwrap_padded_braces = '{'
g.argwrap_tail_comma = 1

--closetag
g.closetag_filetypes = 'html,vue,xhtml'
g.closetag_xhtml_filetypes = 'html,vue,xhtml'

--coc
g.coc_global_extensions = {
  'coc-css',
  'coc-eslint',
  'coc-html',
  'coc-json',
  'coc-snippets',
  'coc-solargraph',
  'coc-tsserver',
  'coc-vetur',
  'coc-yaml',
}

