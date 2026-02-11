vim.cmd("highlight CocFloating guibg=#152238")

require('tokyonight').setup({
  transparent = true,
  styles = {
    sidebars = "transparent"
  }
})

require('kanagawa').setup({
  transparent = true,
  colors = {
      theme = {
          all = {
              ui = {
                  bg_gutter = "none"
              }
          }
      }
  },
  overrides = function(colors)
    local theme = colors.theme
    local makeDiagnosticColor = function(color)
      local c = require("kanagawa.lib.color")
      return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
    end

    return {
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
      DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
      DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
      DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
    }
  end
})

require('nightfox').setup({
  options = {
    transparent = true,
  },
})

require('rose-pine').setup({
  disable_background = true,
})

require('night-owl').setup({
  disable_background = true,
  transparent_background = true,
})

-- vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme night-owl')
vim.cmd('colorscheme tokyonight')
-- vim.cmd('colorscheme kanagawa-wave')
-- vim.cmd('colorscheme nightfox')

vim.cmd 'highlight TelescopeBorder guibg=none'
vim.cmd 'highlight TelescopeTitle guibg=none'


