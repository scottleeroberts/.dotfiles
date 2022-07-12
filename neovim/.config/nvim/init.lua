-------------
-- Global --
-------------
config = vim.env.HOME .. ''

-------------
-- Requires --
-------------
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.theme"
require "user.other_configuration"

require "user.plugin.telescope"
require "user.plugin.assorted"
require "user.plugin.nvim-tree"
require "user.plugin.gitsigns"
