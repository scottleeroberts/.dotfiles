vim.cmd("highlight CocFloating guibg=#152238")

require('tokyonight').setup({
  transparent = true,
  styles = {
    sidebars = "transparent"
  }
})

require('kanagawa').setup({
  transparent = true,
})

require('nightfox').setup({
  options = {
    transparent = true,
  },
})

require('rose-pine').setup({
  disable_background = true,
})

-- vim.cmd('colorscheme tokyonight-storm')
-- vim.cmd('colorscheme kanagawa')
-- vim.cmd('colorscheme nightfox')
vim.cmd('colorscheme rose-pine')
