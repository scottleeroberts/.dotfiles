-------------
-- Global --
-------------
config = vim.env.HOME .. ''

-------------
-- Requires --
-------------
require "user.options"
require "user.keymaps"
require "user.lazy_bootstrap"
require "user.theme"
require "user.other_configuration"
require "user.lsp"

vim.cmd [[highlight! link SignColumn Normal]]

_G.tests = require('user.utils.tests')
