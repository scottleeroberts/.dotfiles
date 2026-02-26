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
  styles = {
    italic = false,
  },
  highlight_groups = {
    Comment = { italic = true },
    Normal = { bg = 'none' },
    NormalNC = { bg = 'none' },
    NormalFloat = { bg = 'base' },
    ['@variable'] = { fg = 'text' },
    ['@variable.member'] = { fg = 'foam' },
    ['@function'] = { fg = 'rose' },
    ['@function.call'] = { fg = 'rose' },
    ['@function.method'] = { fg = 'rose' },
    ['@function.method.call'] = { fg = 'rose' },
    ['@type'] = { fg = 'gold' },
    ['@type.builtin'] = { fg = 'gold' },
    ['@module'] = { fg = 'iris' },
    ['@property'] = { fg = 'foam' },
    ['@field'] = { fg = 'foam' },
    ['@constant'] = { fg = 'gold' },
    ['@lsp.type.function'] = { fg = 'rose' },
    ['@lsp.type.method'] = { fg = 'rose' },
    ['@lsp.type.property'] = { fg = 'foam' },
    ['@lsp.type.variable'] = { fg = 'text' },
    ['@lsp.type.parameter'] = { fg = 'iris' },
    ['@lsp.type.type'] = { fg = 'gold' },
  },
})

require('night-owl').setup({
  disable_background = true,
  transparent_background = true,
})

vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme night-owl')
-- vim.cmd('colorscheme tokyonight')
-- vim.cmd('colorscheme kanagawa-wave')
-- vim.cmd('colorscheme nightfox')

vim.cmd 'highlight Cursor guibg=#ff2040 guifg=#000000'
vim.opt.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'
vim.cmd 'highlight TelescopeBorder guibg=none'
vim.cmd 'highlight TelescopeTitle guibg=none'


