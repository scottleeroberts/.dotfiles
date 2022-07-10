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

require "user.plugin.telescope"
require "user.plugin.nerdtree"
require "user.plugin.assorted"


-- Highlight current column in active pane only
vim.api.nvim_exec([[
  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup END
]], false)

--iabbr
vim.cmd('iabbr pry ::Kernel.binding.pry')

-- Open to last position in file
vim.api.nvim_exec([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif  ]], false)

--highlight on yank
vim.api.nvim_exec([[
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=251, on_visual=true}
]], false)

