-------------
-- Global --
-------------
config = vim.env.HOME .. '/.config/nvim'


-------------
-- Requires --
-------------
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.theme"


-------------
-- Local  ---
-------------
local exec = vim.api.nvim_exec
local cmd = vim.cmd
local g = vim.g
local o = vim.opt


-------------
-- Setup --
-------------
cmd('au FileType * setlocal ai sw=2 sts=2 et')
cmd('filetype plugin indent on')
cmd('syntax on')


----------------
-- Plugins --
----------------

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


-- NerdTree
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
exec([[
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  highlight! link NERDTreeFlags NERDTreeDir
]], false)


-- Highlight current column in active pane only
vim.api.nvim_exec([[
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END
]], false)

-- ruby
g.ruby_indent_block_style = 'do' -- https://github.com/vim-ruby/vim-ruby/blob/master/doc/vim-ruby.txt#L133

-- auto-pairs configuration
g.AutoPairsMultilineClose=0

--argwrap
g.argwrap_padded_braces = '{'
g.argwrap_tail_comma = 1

-- Vue `gf` for components
o.suffixesadd = '.vue'
o.path = '.,app/javascript/**'
g.vue_pre_processors = 'detect_on_enter'

--closetag
g.closetag_filetypes = 'html,vue,xhtml'
g.closetag_xhtml_filetypes = 'html,vue,xhtml'

--coc
g.coc_snippet_prev = '<c-p>'
g.coc_snippet_next = '<c-n>'
g.coc_global_extensions = { 'coc-css', 'coc-eslint', 'coc-html', 'coc-json', 'coc-snippets', 'coc-solargraph', 'coc-tsserver', 'coc-vetur', 'coc-yaml' }

--iabbr
vim.cmd('iabbr pry ::Kernel.binding.pry')

-- Open to last position in file
exec([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif  ]], false)

--highlight on yank
exec([[
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=251, on_visual=true}
]], false)

--telescope configuration
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--line-number',
        '--hidden',
        '--column',
        '--smart-case',
        '--follow'
      },
      prompt_prefix    = ' 🔍 ',
      color_devicons   = true,
      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      generic_sorter   = require('telescope.sorters').get_fzy_sorter,
      file_sorter      = require('telescope.sorters').get_fzy_sorter,

      mappings = {
          i = {
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
          },
      },
      layout_strategy = "flex",
      layout_config = {
        preview_cutoff = 10,
        width = 0.8,
        height = 0.9,
        flex = {
          flip_columns = 170,
        },
      },
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  extensions = {
      fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
      }
  },
}

require('telescope').load_extension('fzy_native')

