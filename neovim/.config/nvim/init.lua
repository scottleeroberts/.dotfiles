-------------
-- Global --
-------------
config = vim.env.HOME

-------------
-- Requires --
-------------
require "user.options"
require "user.keymaps"
require "user.lazy_bootstrap"
require "user.lsp"
require "user.config.treesitter"
require "user.theme"
require "user.other_configuration"

vim.cmd [[highlight! link SignColumn Normal]]

_G.tests = require('user.utils.tests')
