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
      Normal = { bg = "#0c1021" },
      NormalNC = { bg = "#0c1021" },

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

      -- render-markdown.nvim: code block backgrounds (heading bg left at plugin defaults,
      -- which link to Diff*/Visual/CursorColumn for readable contrast on any colorscheme)
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
    -- render-markdown.nvim: code block background (heading bg left at plugin defaults,
    -- which link to Diff*/Visual/CursorColumn for readable contrast on any colorscheme)
    RenderMarkdownCode = { bg = 'surface' },
    RenderMarkdownCodeInline = { bg = 'surface' },
  },
})

require('night-owl').setup({
  disable_background = true,
  transparent_background = true,
})

require('cendre').setup({
  background = 'hard',
  transparent = false,
  italic = false,
  on_highlights = function(hl, c)
    -- Go: interface vs struct distinction (cendre ships both as c.frost)
    hl["@lsp.type.interface"] = { fg = c.frost, italic = true }
    hl["@lsp.type.struct"] = { fg = c.ember }
    -- Ruby: symbols visually distinct from strings (target .ruby variant directly)
    hl["@string.special.symbol.ruby"] = { fg = c.frost }
    -- sidekick.nvim's terminal splits (e.g. the <leader>aa Claude split)
    -- default SidekickChat to link NormalFloat, which cendre uses for a
    -- darker floats/sidebars background. Link it to Normal instead so the
    -- split matches the rest of the editor.
    hl["SidekickChat"] = { link = "Normal" }
  end,
})

-- vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme night-owl')
-- vim.cmd('colorscheme tokyonight')
-- vim.cmd('colorscheme kanagawa-wave')
-- vim.cmd('colorscheme nightfox')
vim.cmd('colorscheme cendre')

vim.cmd 'highlight Cursor guibg=#ff2040 guifg=#000000'
vim.opt.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'
vim.cmd 'highlight TelescopeBorder guibg=none'
vim.cmd 'highlight TelescopeTitle guibg=none'
