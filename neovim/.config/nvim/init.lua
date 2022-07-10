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
require "user.other_configuration"

require "user.plugin.telescope"
require "user.plugin.nerdtree"
require "user.plugin.assorted"

