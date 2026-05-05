require('tokyonight').setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
  },
  on_highlights = function(hl, c)
    -- Ruby: symbols visually distinct from strings (target .ruby variant directly)
    hl["@string.special.symbol.ruby"] = { fg = c.cyan }
    -- Ruby: regex literals
    hl["@string.regexp"] = { fg = c.teal }
    -- Go: interface vs struct distinction (gopls provides these)
    hl["@lsp.type.interface"] = { fg = c.cyan, italic = true }
    hl["@lsp.type.struct"] = { fg = c.yellow }
    -- Go: generics type params
    hl["@lsp.type.typeParameter"] = { fg = c.cyan }
    -- Go: parameters purple (intentional, matches rose-pine iris setup)
    hl["@variable.parameter"] = { fg = c.purple }
    hl["@lsp.type.parameter"] = { fg = c.purple }
  end,
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

      NormalFloat = { bg = theme.ui.bg_p1 },

      DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
      DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
      DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
      DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

      -- Ruby: symbols visually distinct from strings (.ruby suffix needs explicit override)
      ["@string.special.symbol.ruby"] = { fg = theme.syn.identifier },
      ["@string.regexp"] = { fg = theme.syn.regex },

      -- Go: interface vs struct distinction; generics type params
      ["@lsp.type.interface"]     = { fg = theme.syn.type, italic = true },
      ["@lsp.type.struct"]        = { fg = theme.syn.identifier },
      ["@lsp.type.typeParameter"] = { fg = theme.syn.type },

      -- render-markdown.nvim: heading tints and code block backgrounds
      RenderMarkdownH1Bg        = { bg = theme.syn.special2,  blend = 10 },
      RenderMarkdownH2Bg        = { bg = theme.syn.constant,  blend = 10 },
      RenderMarkdownH3Bg        = { bg = theme.syn.string,    blend = 10 },
      RenderMarkdownH4Bg        = { bg = theme.syn.statement, blend = 10 },
      RenderMarkdownH5Bg        = { bg = theme.syn.special1,  blend = 10 },
      RenderMarkdownH6Bg        = { bg = theme.syn.type,      blend = 10 },
      RenderMarkdownCode        = { bg = theme.ui.bg_m1 },
      RenderMarkdownCodeInline  = { bg = theme.ui.bg_m1 },
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
    -- render-markdown.nvim: subtle heading tints that work with transparency
    RenderMarkdownH1Bg = { bg = 'love', blend = 10 },
    RenderMarkdownH2Bg = { bg = 'gold', blend = 10 },
    RenderMarkdownH3Bg = { bg = 'rose', blend = 10 },
    RenderMarkdownH4Bg = { bg = 'iris', blend = 10 },
    RenderMarkdownH5Bg = { bg = 'foam', blend = 10 },
    RenderMarkdownH6Bg = { bg = 'pine', blend = 10 },
    RenderMarkdownCode = { bg = 'surface' },
    RenderMarkdownCodeInline = { bg = 'surface' },
  },
})

require('night-owl').setup({
  disable_background = true,
  transparent_background = true,
})

-- vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme night-owl')
-- vim.cmd('colorscheme tokyonight')
vim.cmd('colorscheme kanagawa-wave')
-- vim.cmd('colorscheme nightfox')

vim.cmd 'highlight Cursor guibg=#ff2040 guifg=#000000'
vim.opt.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'
vim.cmd 'highlight TelescopeBorder guibg=none'
vim.cmd 'highlight TelescopeTitle guibg=none'


